import { Elm } from "./src/Social.elm";

let app = Elm.Social.init();
app.ports.showSsnSubmitStatus.subscribe(ssn => {
  alert(`Submiting social: ${ssn}`);
});
