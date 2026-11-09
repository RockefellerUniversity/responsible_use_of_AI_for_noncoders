## %%{init: {"flowchart": {"htmlLabels": false}}}%%
## flowchart LR
##   P(["Your prompt"]) --> M["Model reads the<br/>whole context"]
##   M --> D{"Needs a tool?"}
##   D -- "Yes" --> T["Harness runs the tool<br/>(e.g. web search)"]
##   T --> C["Result added<br/>to context"]
##   C --> M
##   D -- "No" --> A(["Answer"])

## %%{init: {"flowchart": {"htmlLabels": false}}}%%
## flowchart LR
##   Q1(["You: What does<br/>Ikzf1 do?"]) --> C1["Call 1<br/>answers from<br/>training data"]
##   C1 --> Q2(["You: review current<br/>literature"])
##   Q2 --> C2["Call 2<br/>decides to<br/>search the web"]
##   C2 --> C3["Call 3<br/>runs 4 web<br/>searches"]
##   C3 --> R3[/"+ search results<br/>added"/]
##   R3 --> C4["Call 4<br/>writes the<br/>review"]
