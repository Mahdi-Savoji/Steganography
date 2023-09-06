function [bin] = sc2bin(sc)
asciisc = double(sc);
bin = dec2bin(asciisc,8);
end

