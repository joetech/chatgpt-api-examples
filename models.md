# A Summary of Models
There's good [official models documentation](https://platform.openai.com/docs/models), but here's a summary from my own testing.  The speed, cost, and complexity vary and often the more complex models (and requests) may cost more and be slower.

The combined cost of all tests on this page was around $0.0025.

---

## Text Models (and Google for comparison)
These models are more for natural language questions.  For testing, the prompt is "tell me when Martin Luther King Jr was born".  Interestingly, the more expensive two of these tests did not match what Google responded with.  Your mileage may vary.

### Google
"January 15, 1929, Atlanta, GA"

### text-ada-001
King was born on March 14, 1926, in Louisville, Kentucky.
```
{
    "usage": {
        "prompt_tokens": 9,
        "completion_tokens": 16,
        "total_tokens": 25
    }
}
```

### text-babbage-001
Martin Luther King Jr was born on December 5, 1941, in Memphis, Tennessee.
```
{
    "usage": {
        "prompt_tokens": 9,
        "completion_tokens": 19,
        "total_tokens": 28
    }
}
```

### text-curie-001
Martin Luther King Jr was born on January 15, 1929.
```
{
    "usage": {
        "prompt_tokens": 9,
        "completion_tokens": 14,
        "total_tokens": 23
    }
}
```

### text-davinci-003
Martin Luther King Jr was born on January 15, 1929.
```
{
    "usage": {
        "prompt_tokens": 9,
        "completion_tokens": 14,
        "total_tokens": 23
    }
}
```
----
## Codex Models
Based on GPT-3 models, but also trained on billions of lines of public code, these are designed to understand and generate code.  They are stongest in Python, but also good for JavaScript, Go, Perl, PHP, Ruby, Swift, TypeScript, SQL, and Shell.

For these, our prompt will be "write a shell script that loops through all image files in the current directory and renames them, replacing all spaces with dashes"

## code-cushman-001
Faster and about as good as davinci below

Code from the response:
```
#!/bin/bash

for file in *.jpg
do
  mv "$file" "$(echo $file | tr ' ' '-')"
done
```

Costs:
```
{
    "usage": {
        "prompt_tokens": 25,
        "completion_tokens": 39,
        "total_tokens": 64
    }
}
```

Here, it's assuming all images will be jpg, so all png files are going to get ignored.

## code-davinci-002	
Best for natural language to code conversion and code completions

Code from the response:
```
#!/bin/bash
+
+for file in *
+do
+  mv "$file" `echo $file | tr ' ' '-'`
+done
```

Costs:
```
{
    "usage": {
        "prompt_tokens": 25,
        "completion_tokens": 39,
        "total_tokens": 64
    }
}
```
This response took 95 seconds and only stopped because it went over the max 2,000 tokens I defined in the request.  The resulting code was huge and mostly included the prompt and code repeated over and over.

For this reason, we'll go back to the cushman model and give it more detailed instuctions: "write a shell script that loops through all bmp and jpg and png files in the current directory and renames them, replacing all spaces with dashes"

## code-cushman-001 (with more details)

Code from the response:
```
#!/bin/bash

for i in *.bmp *.jpg *.png
do
    mv "$i" "${i// /-}"
done
```

Costs:
```
{
    "usage": {
        "prompt_tokens": 32,
        "completion_tokens": 38,
        "total_tokens": 70
    }
}
```

Now, we have the results we're after, with a slightly higher cost, but without the need for davinci.  This reinforces OpenAI's recommendation to test with the cheaper models first and move in the direction of davinci when other models don't do what you need.
