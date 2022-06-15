import {Elm} from "./src/Main.elm";
import timeline from "./timeline.json";

let node = document.querySelector("#app");
Elm.Main.init({
  node: node,
  flags: {timeline: timeline}
});
