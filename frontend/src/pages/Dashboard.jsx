import { useNavigate } from "react-router-dom";

function Dashboard() {
  const navigate = useNavigate();

  function logout() {
    localStorage.removeItem("token");
    navigate("/login");
  }

  return (
    <div>
      <h1>Dashboard</h1>

      <h2>🎉 Login Successful</h2>

      <button onClick={logout}>
        Logout
      </button>
    </div>
  );
}

export default Dashboard;