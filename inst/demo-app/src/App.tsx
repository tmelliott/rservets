import "./App.css";
import { useR } from "./lib/rseveApp";

function App() {
  const { R, loading, error } = useR();

  console.log(R);

  return <div className="App">Hello world</div>;
}

export default App;
