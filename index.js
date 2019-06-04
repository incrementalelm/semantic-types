import { Elm } from "./src/Main.elm";

let app = Elm.Main.init();
app.ports.showSsnSubmitStatus.subscribe(ssn => {
  alert(`Submiting social: ${ssn}`);
});
