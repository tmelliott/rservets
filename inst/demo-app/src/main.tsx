import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";

import { Rserve } from "@tmelliott/react-rserve";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <Rserve
      {...{
        host: "ws://localhost:8081",
      }}
    >
      <App />
    </Rserve>
  </React.StrictMode>
);
