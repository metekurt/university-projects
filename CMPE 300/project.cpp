		/*
		Student Name: METE HAN KURT
		Student Number: 2016400339
		Compile Status: Compiling
		Program Status: Working
		Notes: The program first checks the input values. If your input values are different from the desired value, it returns an error. 
		       If the values are correct, the master processor assigns the values in the input.txt file to a two-dimensional array. 
		       Then calculate the exponential distrubition according to the values around a randomly selected pixel. 
		       Slave processors change the values in rows and columns in parallel. 
		       The important point in this correction is the beta and pi values entered by the user. 
		       After editing, the values are sent to the master processor and written to the output.txt file.
		*/
		#include <iostream>
		#include <fstream>
		#include <math.h>
		#include <cstring>
		#include <mpi.h>
		using namespace std;

		// 200x200 is fixed size, so they are defined as fixed.
		const int array_rows = 200;
		const int array_columns = 200;

		// The method which creates 2D array dynamically is called.
		int** matrix(int, int);

		// Main function
		int main(int argc, char *argv[])
		{
			if(argc < 5) //  Returns an error if at least one of the required values is missing.
			{
				cout << "Invalid args\n";
				return 0;
			}
		    int data_order, data_size, slave_count, row_count, i, j, k, val, ii, jj, total, count = 0, T, arc, ran; //  Define the variables we will use.
		    int** temp_array, **temp_array2, receive_data1[200], receive_data2[200]; // Temporary arrays to keep the values to be copied are defined.
			
		    MPI_Request req;
			
		    string input_data = argv[1], output_data = argv[2]; // Input and output values are initialized.
			
		    double beta_value = atof(argv[3]), pi = atof(argv[4]), gamma_value = 0.5 * (log10((1 - pi) / pi)); // Variables to be used for gamma detection.
			
		    MPI_Init(NULL, NULL);
		    MPI_Comm_rank(MPI_COMM_WORLD, &data_order); // Rank of processors
		    MPI_Comm_size(MPI_COMM_WORLD, &data_size); // Total number of processors(n)
		    slave_count = data_size - 1; //   Number of slave processors
		    row_count = 200 / slave_count; // There are 200 rows and number of rows are shared to slave processors equally.

		     
		    if(data_order == 0) // For the master processor..
			{
				
		        ifstream reader;
		        ofstream writer;
				
		        reader.open(input_data); //  Opened file to be read
		        writer.open(output_data); // Opened file to be written
				
		        temp_array = matrix(array_rows,array_columns); //  temp_array was assigned a two-dimensional location of 200x200
		        
				if(reader)
				{   // We read from the file and assigned the values to temp_array.
		            for(i = 0; i < array_rows; i++) // For each row..
					{
		                for(j = 0; j < array_columns; j++) // For each coulmn..
						{
		                    if(reader >> val)
							{
		                        temp_array[i][j] = val; // The value read is thrown into the matrix of the temp_array.
		                    }
		                }
		            }

		        }
				
		        for(i = 1; i < data_size; i++)// Sending to slave processors
				 {
		        	MPI_Send(&(temp_array[(i - 1) * row_count][0]), row_count * array_rows, MPI_INT, i, 0, MPI_COMM_WORLD); 
				}
				
		        temp_array2 = matrix(array_rows,array_columns);// temp_array2 was assigned a two-dimensional location of 200x200
		        
				for(i = 1; i < data_size; i++) // Receiving from slave processors
				   {
					MPI_Recv(&(temp_array2[(i - 1) * row_count][0]), row_count * array_rows, MPI_INT, i, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
		            
		            }   

		           
		        for(i = 0; i < array_rows; i++)  // The values assigned above are written to the file.
				{
		            for(j = 0; j < array_columns; j++)
					{
		                writer << temp_array2[i][j] << " " ; // Writing the assigned values in temp_array2
		            }
		            writer << "\n"; // If line end is reached, move to next line.
		        }
				
		        reader.close();
		        writer.close();
		    } else { //  For slave processors..
		        T = 250000; // Number of Iteration
		        
				 // Two two-dimensional dynamic arrays are created.
		        temp_array2 = matrix(row_count,array_columns);
		        temp_array = matrix(row_count,array_columns);
		        
				MPI_Recv(&(temp_array[0][0]), row_count * array_rows, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

		        

		        for(i = 0; i < row_count; i++)// We just copy temp_array to temp_array2.
				{
		            for(j = 0; j < array_columns; j++)
					{
		                temp_array2[i][j] = temp_array[i][j];
		            }
		        }

		        for(i= 0; i < T; i++){
		            ii = rand() % row_count, jj = rand() % (array_columns) , total = 0; // Assigning a random row and column value to ii and jj.
		            if(ii == 0 || ii == row_count - 1) //For the top rows or bottom rows
					{

						switch(data_order)// Processes to be performed in processor order.
				 {

				        case 1: //  For the 1st slave processor..
		            
		                    if(ii != 0) // For the last line of the first slave processor.
							{
		                        for(j = ii - 1; j < ii + 1; j++)
								{
		                            for(k = jj - 1; k < jj + 2; k++)
									{
		                                total += temp_array2[j][k];
		                            }
		                        }
		                        total += receive_data2[jj - 1] + receive_data2[jj] + receive_data2[jj + 1] - temp_array2[ii][jj];
		                    }
						 	else if(ii==0)  // For the first line of the first slave processor.
							{
		                        for(j = ii ; j < ii + 2; j++)
		                        {
		                            for(k = jj - 1; k < jj + 2; k++)
		                            {
		                                total += temp_array2[j][k];
		                            }
		                        }
		                        total=total-temp_array2[ii][jj];
		                    }
					       break;

				       default:
				          if (data_order == data_size-1)	//  For the last slave processor..
					      {

		                   if(ii!= row_count-1) //  For the first line of the last slave processor.
						 	{
		                        for(j = ii; j < ii + 2; j++) 
								{
		                            for(k = jj - 1 ; k < jj + 2; k++) // Controls from the previous to the next
									{
		                                total += temp_array2[j][k];
		                            }
		                        }
		                        total += receive_data1[jj - 1] + receive_data1[jj] + receive_data1[jj + 1] - temp_array2[ii][jj];
		                    }
		                    else if(ii==row_count-1)  // For the last line of the last slave processor.
							{
		                        for(j = ii-1 ; j < ii + 1; j++)
		                        {
		                            for(k = jj - 1; k < jj + 2; k++) // Controls from the previous to the next
		                            {
		                                total += temp_array2[j][k];
		                            }
		                        }
		                        total=total-temp_array2[ii][jj];
		                    }
				     }
				     else //  For the slave processors in middle..
				     {
				      	
		                    if(ii == 0)// For the first line of a slave processor in the middle.
							{
		                        for(j = ii; j < ii + 2; j++) 
								{
		                            for(k = jj - 1; k < jj + 2; k++) // Controls from the previous to the next
									{
		                                total += temp_array2[j][k];
		                            }
		                        }
		                        total += receive_data1[jj - 1] + receive_data1[jj] + receive_data1[jj + 1] - temp_array2[ii][jj];
		                    }
							else // For the last line of a slave processor in the middle.
							{ 
		                        for(j = ii - 1; j < ii + 1; j++) 
								{
		                            for(k = jj - 1; k < jj + 2; k++) // Controls from the previous to the next
									{
		                                total += temp_array2[j][k];
		                            }
		                        }
		                        total += receive_data2[jj - 1] + receive_data2[jj] + receive_data2[jj + 1] - temp_array2[ii][jj];
		                    }
				     }
				           
		        }
		    
		            }
						else //For neither the first row nor the last row of any slave processor.
						{
			                for(j = ii - 1; j < ii + 2; j++) 
							{
			                    for(k = jj - 1; k < jj + 2; k++) 
								{
			                        total += temp_array2[j][k];
			                    }
			                }
			                total = total - temp_array2[ii][jj];
		            }
					// Calculates the exponential distribution according to the values around one point
		            arc = (-2) * gamma_value * temp_array[ii][jj] * temp_array2[ii][jj] + (-2) * beta_value * temp_array2[ii][jj] * total; 
		            ran = rand(); //  A random number is assigned to ran
		            
					if(log(ran) < exp(arc))
					{
			                temp_array2[ii][jj] = -1 * temp_array2[ii][jj]; // The pixel is flipped from 1 to -1
		            }


		            switch(data_order) //  Processes to be performed in processor order.
					{
					case 1:   // If it is 1st slave..
		                
		                MPI_Send((temp_array2[row_count - 1]), 1 * array_rows, MPI_INT, 2, 0, MPI_COMM_WORLD);    //Last row of P1 was sent to temp_array2
		                MPI_Recv(receive_data2, array_rows, MPI_INT, 2, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);   //Last row of P1 was received by receive_data2
						break;
					
		     
		            default:
				     if (data_order == data_size-1)  // If it is the last slave..	
					 {

		                MPI_Send((temp_array2[0]), 1 * array_rows, MPI_INT, data_size - 2, 0, MPI_COMM_WORLD);    //First row of P(n-1) was sent to temp_array2
		                MPI_Recv(receive_data1, array_rows, MPI_INT, data_size - 2, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE); //First row of P1(n-1) was received by receive_data1
				     }
				     else //  If they are middle slaves..
				     {
				      	
		                MPI_Send((temp_array2[0]), 1 * array_rows, MPI_INT, data_order - 1, 0, MPI_COMM_WORLD);     //First row of P(n) was sent to temp_array2
		                MPI_Recv(receive_data1, array_rows, MPI_INT, data_order - 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);  //First row of P(n) was received by receive_data1
		               	MPI_Send((temp_array2[row_count - 1]), 1 * array_rows, MPI_INT, data_order + 1, 0, MPI_COMM_WORLD);   //Last row of P(n) was sent to temp_array2
		                MPI_Recv(receive_data2, array_rows, MPI_INT, data_order+1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);  //Last row of P(n) was received by receive_data2
				     }
				 }

		            
		        }
		            //  Slave contents are sent to master processor
		        MPI_Send(&(temp_array2[0][0]), row_count * array_rows, MPI_INT, 0, 1, MPI_COMM_WORLD);
		    }
		    MPI_Finalize(); //Terminates the calling MPI process’s execution environment.
		}

		//  Two-dimensional dynamic array generating method
		int** matrix(int r, int c)
		{
			int i;
		    int* d = (int *)malloc(r * c * sizeof(int));
		    int** new_map= (int **)malloc(r * sizeof(int *));
		    for (i = 0; i < r; i++)
			{
		        new_map[i] = &(d[c * i]);
			}

		    return new_map;
		}
