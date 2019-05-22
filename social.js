import { Elm } from "./src/Social.elm";

let app = Elm.Social.init();
app.ports.submitSsn.subscribe(ssn => {
  alert(`Submiting social: ${ssn}`);
});
