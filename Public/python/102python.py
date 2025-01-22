import pandas as pd
import codecs
import os

# fax code ,Remember to change the name of the fax file
file_shift_jis = r"???"
file_utf8 = '2024-07-5--2024-07-5_utf8.csv'

# Attempt to convert the file encoding from cp932 to UTF-8, ignoring erroneous bytes
try:
    with codecs.open(file_shift_jis, 'r', 'cp932', errors='ignore') as f:
        text = f.read()
        with codecs.open(file_utf8, 'w', 'utf-8') as f_out:
            f_out.write(text)
except Exception as e:
    print(f"Error converting file encoding: {e}")

try:
    faxmatome_df = pd.read_csv(file_utf8, low_memory=False)

    # Filter data to retain rows where the 'ステータス' column value is "送達"
    filtered_df = faxmatome_df[faxmatome_df['ステータス'] == '送達']
    # Remove duplicates based on the 'FAX' column
    filtered_df = filtered_df.drop_duplicates(subset=['FAX'])

    lis_df = pd.DataFrame({
        '配信SYS': '',  
        'リスト種別': filtered_df['統一大分類'],
        'shiten_id': '', 
        'shiten_name': '',  
        'sort': '',  
        '都道府県': filtered_df['都道府県'],
        'FAXのカウント': filtered_df['FAX']
    })

    # Save the transformed DataFrame to a new CSV file
    lis_df.to_csv('list.csv', index=False)

except Exception as e:
    print(f"Error processing data: {e}")

# Read the transformed CSV file
lis_df = pd.read_csv('list.csv')

# Set a fixed value for the '配信SYS' column
lis_df['配信SYS'] = 'NEXLINK'

# Map values in the 'リスト種別' column
def map_risuto_shubetsu(value):
    if pd.isna(value):
        return 'その他' 
    elif value in ['農業，林業', '漁業']:
        return '農，林，漁業'
    elif value in '鉱業，採石業，砂利採取業':
        return '鉱，採石，砂利採取業'
    elif value == '建設業':
        return '建設業'
    elif value == '製造業':
        return '製造業'
    elif value == '電気・ガス・熱供給・水道業':
        return '電気，ガス，熱供給，水道業'
    elif value in '運輸業，郵便業':
        return '運輸業，郵便業'
    elif value in '卸売業，小売業':
        return '卸売業，小売業'
    elif value in ['宿泊業，飲食サービス業', '生活関連サービス業，娯楽業']:
        return '宿泊，飲食，生活，娯楽業'
    elif value == '教育，学習支援業':
        return '教育，学習支援業'
    elif value == '医療，福祉':
        return '医療，福祉業'
    else:
        return 'その他'

# Apply the mapping function
lis_df['リスト種別'] = lis_df['リスト種別'].apply(map_risuto_shubetsu)

# Create a dictionary containing the corresponding shiten_id, shiten_name, and sort values for 都道府県
shiten_data = {
    '北海道': (1, '北海道', 1),
    '青森県': (2, '東北', 2),
    '秋田県': (2, '東北', 3),
    '岩手県': (2, '東北', 4),
    '山形県': (2, '東北', 5),
    '宮城県': (2, '東北', 6),
    '福島県': (2, '東北', 7),
    '茨城県': (3, '北関東', 8),
    '栃木県': (3, '北関東', 9),
    '埼玉県': (3, '北関東', 10),
    '群馬県': (3, '北関東', 11),
    '山梨県': (3, '北関東', 12),
    '千葉県': (4, '関東', 13),
    '東京都': (4, '関東', 14),
    '神奈川県': (4, '関東', 15),
    '長野県': (5, '北陸', 16),
    '新潟県': (5, '北陸', 17),
    '富山県': (5, '北陸', 18),
    '石川県': (5, '北陸', 19),
    '福井県': (5, '北陸', 20),
    '岐阜県': (6, '東海', 21),
    '愛知県': (6, '東海', 22),
    '静岡県': (6, '東海', 23),
    '滋賀県': (6, '東海', 24),
    '三重県': (6, '東海', 25),
    '奈良県': (7, '関西', 26),
    '京都府': (7, '関西', 27),
    '大阪府': (7, '関西', 28),
    '和歌山県': (7, '関西', 29),
    '兵庫県': (7, '関西', 30),
    '香川県': (7, '関西', 31),
    '徳島県': (7, '関西', 32),
    '愛媛県': (7, '関西', 33),
    '高知県': (7, '関西', 34),
    '鳥取県': (8, '中国', 35),
    '島根県': (8, '中国', 36),
    '岡山県': (8, '中国', 37),
    '広島県': (8, '中国', 38),
    '山口県': (8, '中国', 39),
    '福岡県': (9, '九州', 40),
    '大分県': (9, '九州', 41),
    '宮崎県': (9, '九州', 42),
    '鹿児島県': (9, '九州', 43),
    '佐賀県': (9, '九州', 44),
    '熊本県': (9, '九州', 45),
    '長崎県': (9, '九州', 46),
    '沖縄県': (10, '沖縄', 47),
    '本社': (11, '本社', 48),
    '不明': (11, '本社', 49)
}

# Map the 'shiten_id', 'shiten_name', and 'sort' columns
lis_df['shiten_id'] = lis_df['都道府県'].map(lambda x: shiten_data.get(x, (None, None, None))[0])
lis_df['shiten_name'] = lis_df['都道府県'].map(lambda x: shiten_data.get(x, (None, None, None))[1])
lis_df['sort'] = lis_df['都道府県'].map(lambda x: shiten_data.get(x, (None, None, None))[2])

# Save the processed DataFrame to a new CSV file
lis_df.to_csv('lis_processed.csv', index=False)

# Read the processed CSV file
df = pd.read_csv('lis_processed.csv')

# Group by specified columns and count the number of rows
grouped_df = df.groupby(['配信SYS', 'リスト種別', 'shiten_id', 'shiten_name', 'sort', '都道府県']).size().reset_index(name='FAXのカウント')

grouped_df['shiten_id'] = grouped_df['shiten_id'].astype(int)
grouped_df['sort'] = grouped_df['sort'].astype(int)

# Print the result
print(grouped_df)

# Save the grouped result to a new faxfinal.csv file
grouped_df.to_csv('This_Month_Fax.csv', index=False, encoding='shift-jis')

try:
    os.remove(file_utf8)
    os.remove('list.csv')
    os.remove('lis_processed.csv')
except Exception as e:
    print(f"Error deleting intermediate files: {e}")












# 追客 code，Remember to change the name of the 追客 file
file_shift_jis = r"???"
file_utf8 = '2024-07-5--2024-07-5_utf8.csv'


if os.path.exists(file_shift_jis):
    # Process the file if it exists



    try:
        with codecs.open(file_shift_jis, 'r', 'cp932', errors='ignore') as f:
            text = f.read()
            with codecs.open(file_utf8, 'w', 'utf-8') as f_out:
                f_out.write(text)
    except Exception as e:
        print(f"Error converting file encoding: {e}")

    try:
        faxmatome_df = pd.read_csv(file_utf8, low_memory=False)

        filtered_df = faxmatome_df[faxmatome_df['ステータス'] == '送達']
        filtered_df = filtered_df.drop_duplicates(subset=['FAX'])

        lis_df = pd.DataFrame({
            '配信SYS': '', 
            'リスト種別': '',  
            'shiten_id': '', 
            'shiten_name': '',  
            'sort': '',  
            '都道府県': filtered_df['都道府県'],
            'FAXのカウント': filtered_df['FAX']
        })

        lis_df.to_csv('list.csv', index=False)

    except Exception as e:
        print(f"Error processing data: {e}")

    lis_df = pd.read_csv('list.csv')

    lis_df['配信SYS'] = 'NEXLINK'

    lis_df['リスト種別'] = '追客'
    shiten_data = {
        '北海道': (1, '北海道', 1),
        '青森県': (2, '東北', 2),
        '秋田県': (2, '東北', 3),
        '岩手県': (2, '東北', 4),
        '山形県': (2, '東北', 5),
        '宮城県': (2, '東北', 6),
        '福島県': (2, '東北', 7),
        '茨城県': (3, '北関東', 8),
        '栃木県': (3, '北関東', 9),
        '埼玉県': (3, '北関東', 10),
        '群馬県': (3, '北関東', 11),
        '山梨県': (3, '北関東', 12),
        '千葉県': (4, '関東', 13),
        '東京都': (4, '関東', 14),
        '神奈川県': (4, '関東', 15),
        '長野県': (5, '北陸', 16),
        '新潟県': (5, '北陸', 17),
        '富山県': (5, '北陸', 18),
        '石川県': (5, '北陸', 19),
        '福井県': (5, '北陸', 20),
        '岐阜県': (6, '東海', 21),
        '愛知県': (6, '東海', 22),
        '静岡県': (6, '東海', 23),
        '滋賀県': (6, '東海', 24),
        '三重県': (6, '東海', 25),
        '奈良県': (7, '関西', 26),
        '京都府': (7, '関西', 27),
        '大阪府': (7, '関西', 28),
        '和歌山県': (7, '関西', 29),
        '兵庫県': (7, '関西', 30),
        '香川県': (7, '関西', 31),
        '徳島県': (7, '関西', 32),
        '愛媛県': (7, '関西', 33),
        '高知県': (7, '関西', 34),
        '鳥取県': (8, '中国', 35),
        '島根県': (8, '中国', 36),
        '岡山県': (8, '中国', 37),
        '広島県': (8, '中国', 38),
        '山口県': (8, '中国', 39),
        '福岡県': (9, '九州', 40),
        '大分県': (9, '九州', 41),
        '宮崎県': (9, '九州', 42),
        '鹿児島県': (9, '九州', 43),
        '佐賀県': (9, '九州', 44),
        '熊本県': (9, '九州', 45),
        '長崎県': (9, '九州', 46),
        '沖縄県': (10, '沖縄', 47),
        '本社': (11, '本社', 48),
        '不明': (11, '本社', 49)
    }

    lis_df['shiten_id'] = lis_df['都道府県'].map(lambda x: shiten_data.get(x, (None, None, None))[0])
    lis_df['shiten_name'] = lis_df['都道府県'].map(lambda x: shiten_data.get(x, (None, None, None))[1])
    lis_df['sort'] = lis_df['都道府県'].map(lambda x: shiten_data.get(x, (None, None, None))[2])

    lis_df.to_csv('lis_processed.csv', index=False)

    df = pd.read_csv('lis_processed.csv')

    grouped_df = df.groupby(['配信SYS','リスト種別','shiten_id', 'shiten_name', 'sort', '都道府県']).size().reset_index(name='FAXのカウント')

    grouped_df['shiten_id'] = grouped_df['shiten_id'].astype(int)
    grouped_df['sort'] = grouped_df['sort'].astype(int)

    grouped_df.to_csv('customerfaxfinal.csv', index=False, encoding='shift-jis')

    try:
        os.remove(file_utf8)
        os.remove('list.csv')
        os.remove('lis_processed.csv')
    except Exception as e:
        print(f"Error deleting intermediate files: {e}")
        

    # Merge 追客 and fax, read the two faxfinal.csv and customerfaxfinal.csv files
    fax_df = pd.read_csv('This_Month_Fax.csv', encoding='shift-jis')
    customer_df = pd.read_csv('customerfaxfinal.csv', encoding='shift-jis')

    customer_df = customer_df.rename(columns={
        'リスト種別': 'リスト種別',
        'shiten_id': 'shiten_id',
        'shiten_name': 'shiten_name',
        'sort': 'sort',
        '都道府県': '都道府県',
        'FAXのカウント': 'FAXのカウント'
    })

    # data merge
    merged_df = pd.concat([fax_df, customer_df], ignore_index=True)
    merged_df.to_excel('This_Month_Fax.xlsx', index=False)

    try:
            os.remove('This_Month_Fax.csv')
            os.remove('customerfaxfinal.csv')
    except Exception as e:
            print(f"Error deleting intermediate files: {e}")
        
        
else:

     # File does not exist, directly save grouped_df to This_Month_Fax.xlsx
    try:
        grouped_df = pd.read_csv('This_Month_Fax.csv', encoding='shift-jis')
        grouped_df.to_excel('This_Month_Fax.xlsx', index=False)
    except Exception as e:
        print(f"Error processing the file directly: {e}")
    try:
            os.remove('This_Month_Fax.csv')
    except Exception as e:
            print(f"Error deleting intermediate files: {e}")