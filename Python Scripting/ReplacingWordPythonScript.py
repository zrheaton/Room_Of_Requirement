import string

# Function to remove punctuation
def remove_punctuation(word):
    return ''.join(char for char in word if char not in string.punctuation)

# Function to replace a specific word in a string with another word
def replace_word(original_text, old_word, new_word):
    return original_text.replace(old_word, new_word)

# Open and read the file
with open("C:\\Users\\17206\Desktop\\BuildingTheAI\\HPSSChapter1_757Tokens..txt", 'r') as file:
    text = file.read()

# Example of replacing words (you can modify this as needed)
text = replace_word(text, "black", "ZACKATTACK")

# Convert text to lower case and split into words
words = text.lower().split()

# Remove punctuation from each word
words = [remove_punctuation(word) for word in words]

# Count the frequency of each word
word_count = {}
for word in words:
    if word in word_count:
        word_count[word] += 1
    else:
        word_count[word] = 1

# Print the word counts
for word, count in word_count.items():
    print(word, count)
