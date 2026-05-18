# Rule-Based Expert System for Disease Diagnosis

print("---- Disease Diagnosis Expert System ----")

fever = input("Do you have fever? (yes/no): ")
cough = input("Do you have cough? (yes/no): ")
rash = input("Do you have rash? (yes/no): ")
headache = input("Do you have headache? (yes/no): ")
vomiting = input("Do you have vomiting? (yes/no): ")

# Applying Rules

if fever == "yes" and cough == "yes":
    print("Diagnosis: You may have Flu.")

elif fever == "yes" and rash == "yes":
    print("Diagnosis: You may have Measles.")

elif headache == "yes" and vomiting == "yes":
    print("Diagnosis: You may have Migraine.")

else:
    print("Diagnosis: Unable to determine disease. Please consult doctor.")