with open("C:\\Users\\17206\Desktop\\BuildingTheAI\\HPSSChapter1_757Tokens..txt", 'r') as file:
    text = file.read()
    words = text.split()
word_count = {}
for word in words:
    if word in word_count:
        word_count[word] += 1
    else:
        word_count[word] = 1
for word, count in word_count.items():
    print(word, count)



