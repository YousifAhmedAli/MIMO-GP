
function convertFileToFixedBinary(input_file, output_file, m, n)
    % input_file  : path to input .txt file with decimal numbers (one per line)
    % output_file : path to output .txt file with fixed-point binary values
    % m           : number of integer bits
    % n           : number of fractional bits
    input_file='C:\Users\yousi\OneDrive\Desktop\New folder\dec_output.txt';
    output_file='C:\Users\yousi\OneDrive\Desktop\New folder\output_binary.txt';
    m=4;
    n=0;
    total_bits = m + n;  %  m int + n frac
    scale = 2^n;

    % Read data from file
    data = load(input_file);  % assumes one decimal value per line

    fid = fopen(output_file, 'w');

    for i = 1:length(data)
        val = round(data(i) * scale);

        % Clamp to valid range
        max_val = 2^(total_bits - 1) - 1;
        min_val = -2^(total_bits - 1);
        val = min(max(val, min_val), max_val);

        % Two's complement binary conversion
        if val < 0
            bin_str = dec2bin(2^total_bits + val, total_bits);
        else
            bin_str = dec2bin(val, total_bits);
        end

        fprintf(fid, '%s\n', bin_str);
    end

    fclose(fid);
    fprintf('Fixed-point binary values written to: %s\n', output_file);
end


