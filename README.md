# Custom Cmd Pattern

This illustrates the pattern for creating an intermediary custom type representing all of the possible Cmds you can have in your application. Some of the benefits include:

- Now you can test your `Cmd`s more easily
- You can see the possible `Cmd`s all in one place so you can more clearly understand the possible side effects
- You can "create your own Cmds", for example you can represent global state changes like opening a modal window

## Running the App

```shell
npm install
npm start
```
