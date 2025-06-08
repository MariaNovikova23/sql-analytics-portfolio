import pandas as pd
import matplotlib.pyplot as plt

# Загружаем Excel
df = pd.read_excel('sales_data.xlsx')

# Добавляем колонку "Выручка"
df['revenue'] = df['quantity'] * df['price']

# Группируем по категориям
category_revenue = df.groupby('category')['revenue'].sum()

# Строим график
category_revenue.plot(kind='bar', color='skyblue', title='Выручка по категориям')
plt.ylabel('Выручка')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('sales_chart.png')

![image](https://github.com/user-attachments/assets/f54b765b-24e8-45dd-8e44-b19fa0b1c8f2)

