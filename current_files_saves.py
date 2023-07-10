import os

# Set the directory where the files will be saved
directory = "./"  # current directory

# Iterate over the current values from 0.04 to 0.20
for current in range(4, 21, 1):  # 21 is exclusive
    # Construct the input file name
    current_str = f"{current:02}"  # Format current value with leading zeros
    input_file = f"STNO_20nm_{current_str}Amp.txt"

    # Read the template file and replace the current value
    with open("STNO_20nm_06Amp.txt", "r") as template_file:
        template_content = template_file.read()
        modified_content = template_content.replace("Jc:= 0.06", f"Jc:= {current/100:.2f}")

    # Write the modified content to the new file
    with open(input_file, "w") as output_file:
        output_file.write(modified_content)

    print(f"File '{input_file}' has been created.")

print("All files have been created.")