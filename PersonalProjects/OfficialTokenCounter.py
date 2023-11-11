#This is a script that I am currently working on to count tokens via API. Still not 100% on why it doesnt work.


import openai

def get_model_response_and_token_count(prompt):
    openai.api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # Replace with your actual API key
    
    response = openai.ChatCompletion.create(
      model="gpt-3.5-turbo",
      messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
        ]
    )
    
    text_response = response.choices[0].message['content'].strip()
    total_tokens = response['usage']['total_tokens']
    return text_response, total_tokens

def main():
    user_input = input("Enter your input: ")

    model_response, token_count = get_model_response_and_token_count(user_input)
    
    print(f"Model response: {model_response}")
    print(f"Total tokens used (including input and response): {token_count}")

if __name__ == "__main__":
    main()
