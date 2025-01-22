import pandas as pd
import openpyxl
from datetime import datetime
import os

# File paths
file_shift_jis = r"???"
file_utf8 = r"???"

# Attempt to convert the Excel file to UTF-8 encoded CSV
try:
    # Read the Excel file
    df = pd.read_excel(file_shift_jis, sheet_name="Fax Number")

    # Save to CSV with UTF-8 encoding
    df.to_csv(file_utf8, index=False, encoding='utf-8')
except Exception as e:
    
    print(f"Error converting file encoding: {e}")

# Process the CSV file
try:
    # Read the UTF-8 encoded CSV file
    faxmatome_df = pd.read_csv(file_utf8, low_memory=False)

    # Filter data to retain rows where the 'ステータス' column value is "送達"
    filtered_df = faxmatome_df[faxmatome_df['ステータス'] == '送達']

    # Count the number of unique faxes for the '送達' status
    num_faxes = filtered_df['FAX'].nunique()

    # Get the date from the Excel file (assuming it's in cell G2)
    date_value = pd.read_excel(file_shift_jis, sheet_name="Fax Number", usecols="G", nrows=1).iloc[0, 0]
    # Convert the date to a datetime object and format it as 'YYYY-MM-DD'
    if isinstance(date_value, (str, pd.Timestamp)):
        date_value = pd.to_datetime(date_value).strftime('%Y-%m-%d')
    else:
        date_value = pd.to_datetime(str(date_value)).strftime('%Y-%m-%d')
    # Create a new DataFrame with the required columns
    lis_df = pd.DataFrame({
        'Date': [date_value],
        'ステータス': ['送達'],
        'Number of Faxes': [num_faxes]
    })

    # Save the transformed DataFrame to a new Excel file
    lis_df.to_excel(r"???", index=False)

    print("Processing complete.")
except Exception as e:
    print(f"Error processing data: {e}")
    
finally:
    # Clean up intermediate CSV file if exists
    if os.path.exists(file_utf8):
        os.remove(file_utf8)
        
    if os.path.exists(file_shift_jis):
        os.remove(file_shift_jis)







def convert_xlsx_to_csv_utf8(folder_path):
    if not os.path.exists(folder_path):
        print(f"The directory {folder_path} does not exist.")
        return

    for file_name in os.listdir(folder_path):
        if file_name.endswith(".xlsx"):
            file_path = os.path.join(folder_path, file_name)
            csv_file_path = os.path.join(folder_path, os.path.splitext(file_name)[0] + ".csv")
            
            try:
                # Read the Excel file
                df = pd.read_excel(file_path, dtype=str)  # Read the file with all columns as strings
                
                # Ensure there's at least one column
                if df.shape[1] > 0:
                    # Prepend '0' to each value in the first column
                    def prepend_zero(value):
                        # Convert value to string, strip any leading/trailing whitespace, and prepend '0'
                        return '0' + str(value).strip() if str(value).strip() else '0'

                    # Apply the function to the first column
                    df.iloc[:, 0] = df.iloc[:, 0].apply(prepend_zero)
                    
                # Save it as a CSV with UTF-8 encoding
                df.to_csv(csv_file_path, index=False, encoding='utf-8')
                
                print(f"Converted {file_name} to {os.path.basename(csv_file_path)}")
                
                # Remove the original Excel file
                os.remove(file_path)
            except Exception as e:
                print(f"Failed to convert {file_name}: {e}")

# Folder path
folder_path = r"???"
convert_xlsx_to_csv_utf8(folder_path)