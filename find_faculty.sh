#!/bin/bash

# FILES TO READ/WRITE
response_raw="./raw.txt"
parsed_names="./parsed_faculty_staff.txt"

# REQUEST
curl -s "https://www.tntech.edu/engineering/programs/csc/faculty-and-staff.php" > $response_raw

# ONE SHOT
#    parse name headers                      parse first and last names              weird Rebecca Hahnert formatting strip
grep "<h4><strong>" $response_raw | grep -Eo "[A-Za-z]+\s(\&nbsp)?;?[A-Za-z]+" | sed "s/&nbsp;//g" > $parsed_names
