import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import streamlit as st

data = pd.read_csv('/Users/saidkardic/Desktop/Wine Ratings per Countries')
fig, ax1 = plt.subplots(figsize=(10, 6))
ax2 = ax1.twinx()

# Plot the average wine rating as thinner red bars
ax1.bar(data['name'], data['avg_wine_rating'], color='red', alpha=0.4, width=0.4)

# Plot the user and wine counts as line charts
ax2.plot(data['name'], data['users_count'], marker='o', label='User Count')
ax2.plot(data['name'], data['wines_count'], marker='o', label='Wine Count')

# Customize the left y-axis (rating scale)
ax1.set_ylabel('Average Wine Rating', color='red')
ax1.tick_params(axis='y', labelcolor='red')

# Customize the right y-axis (user and wine counts)
ax2.set_ylabel('Count')
ax2.tick_params(axis='y')

# Set the chart title
ax1.set_title('Countries with Highest Average Wine Ratings')

# Rotate the x-axis labels for better readability
plt.xticks(rotation=90)

# Show the legend
ax2.legend(loc='upper left')

# Display the chart using Streamlit
st.pyplot(fig)