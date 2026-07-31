---
name: python-developer
description: A skill for writing best-practice Python code with type hints, Google-style docstrings, and adherence to the Zen of Python.
---

# Python Developer Skill

This skill guides the AI to write high-quality, Pythonic code that is consistent, readable, and robust.

## Core Rules

### 1. Type Hints
*   **Mandatory Usage**: Use type hints (annotations) for **all** function arguments, return values, and class attributes.
*   **Custom Types**: If complex or repeated type definitions are needed, defined them in `utils/type_hints.py` and import them. Do not clutter the main logic with verbose type aliases if they can be centralized.
    *   Example: `from utils.type_hints import DataFrameOrSeries`

### 2. Documentation
*   **Google Style**: Every function, method, class, and module must have a docstring following the [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings).
*   **Structure**:
    *   **Summary**: A clear, concise one-line summary.
    *   **Args**: List each argument with its type and description.
    *   **Returns**: Describe the return value and its type.
    *   **Raises**: List all exceptions that are consistently raised.

### 3. The Zen of Python
Adhere strictly to the philosophy of Python:

> Beautiful is better than ugly.
> Explicit is better than implicit.
> Simple is better than complex.
> Complex is better than complicated.
> Flat is better than nested.
> Sparse is better than dense.
> Readability counts.
> Special cases aren't special enough to break the rules.
> Although practicality beats purity.
> Errors should never pass silently.
> Unless explicitly silenced.
> In the face of ambiguity, refuse the temptation to guess.
> There should be one-- and preferably only one --obvious way to do it.
> Although that way may not be obvious at first unless you're Dutch.
> Now is better than never.
> Although never is often better than *right* now.
> If the implementation is hard to explain, it's a bad idea.
> If the implementation is easy to explain, it may be a good idea.
> Namespaces are one honking great idea -- let's do more of those!

## Code Quality Standards
*   **Readability**: Prioritize code that is easy for humans to read.
*   **Simplicity**: Avoid over-engineering. If a simple solution exists, use it.
*   **Explicit Handling**: Do not suppress errors silently. Handle them explicitly or let them propagate with context.
