---
layout: post
title: Running an LLM locally
---

I've been experimenting with LLM's recently and found a neat tool to easily run LLM's
locally on your machine. It's a python library called [LLM](https://llm.datasette.io/en/stable/).

Install it with `pip install llm`. You can now interact with openai models, but if you
want can install gpt4all to run local models.

Install the gpt4all plugin `llm install gpt4all`

See available models with `llm models` and pick one you'd like to try.

To download a model to your machine and run a query against it:

`llm -m replit-code-v1_5-3b-q4_0 "replace all commas in a string in plain javascript"`

The output is hilarious:

```javascript
  var str = "Hello,,world";
  console.log(str); // Hello,,,,world

  function replaceAllComasInStringWithoutUsingLibrariesOrFrameworksWithoutReplacingTheCommaCharacterWithAnyOtherCharacters() {
    return (
      String("" + arguments[0])
        .split(",")
          /*replace comma character with empty string*/
            -> Array<string>
              :: map(s => s.trim())
                | join("")
                  //return a single value as the result of this function call, instead if you want to return an array or object then use "->" in place and put your logic between brackets "{}".
    );
  }

  console.log("Hello,,world");
```

You can even create an alias for easier access:

`llm aliases set replit replit-code-v1_5-3b-q4_0`

To interact with OpenAI models, set your API key with: `llm keys set openai`

Now you can query GPT with  `llm "replace all commas in a string with plain javascript"`

```
To replace all commas in a string with JavaScript, you can use the `replace()` method with
a regular expression as the first argument and the replacement character or string as the
second argument.

Here's an example:

```javascript
var str = "Hello, world, this, is, an, example";

// Replace all commas with a space
var newStr = str.replace(/,/g, ' ');

console.log(newStr); // "Hello world this is an example"
```

In the above example, the regular expression `/,/g` matches all commas in the string
`str`. The `g` flag stands for "global" and ensures that all occurrences of the comma will
be replaced, not just the first one. The `' '` is the replacement string, which in this
case is a space.
```

This response is definitely way more useful.

Another neat trick is that you can analyze code with openai:

`cat file.rb | llm -s "Explain this code"`
