function snr = SNR(y_filtered,y)
         snr = 10*log10(y'*y/((y_filtered-y)'*(y_filtered-y)));% SNR in [dB]
end