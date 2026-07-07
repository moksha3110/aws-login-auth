import { useNavigate } from "react-router-dom";

function Dashboard() {
  const navigate = useNavigate();

  function logout() {
    localStorage.removeItem("token");
    navigate("/login");
  }

  return (
    <div className="dashboard-container">

      <div className="dashboard-card">

        <div className="dashboard-header">

          <div className="dashboard-icon">
            🎉
          </div>

          <h1>Welcome!</h1>

          <p>
            Login successful. You are now authenticated.
          </p>

        </div>

        <div className="dashboard-grid">

          <div className="info-card">
            <h3>🔐 Authentication</h3>
            <p>JWT Authentication</p>
            <span className="status success">Active</span>
          </div>

          <div className="info-card">
            <h3>☁️ Cloud</h3>
            <p>AWS Infrastructure</p>
            <span className="status success">Running</span>
          </div>

          <div className="info-card">
            <h3>💾 Database</h3>
            <p>Amazon RDS MySQL</p>
            <span className="status success">Connected</span>
          </div>

          <div className="info-card">
            <h3>🔑 Secrets</h3>
            <p>AWS Secrets Manager</p>
            <span className="status success">Secure</span>
          </div>

        </div>

        <div className="tech-stack">

          <h2>Project Stack</h2>

          <div className="badges">

            <span>React</span>
            <span>Vite</span>
            <span>API Gateway</span>
            <span>Lambda</span>
            <span>RDS</span>
            <span>Terraform</span>
            <span>ALB</span>
            <span>EC2</span>

          </div>

        </div>

        <button
          className="logout-btn"
          onClick={logout}
        >
          Logout
        </button>

      </div>

    </div>
  );
}

export default Dashboard;