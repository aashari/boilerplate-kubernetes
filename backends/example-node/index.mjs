// app.js
import express from 'express';

const app = express();
const port = 3000;

// Main service function
export function mainService() {
    return {
        status: true,
        message: 'hello world!'
    };
}

// Health service function
export function healthCheckService() {
    return {
        status: true,
        message: 'Service is healthy'
    };
}

// Main controller
app.get('/', (req, res) => {
    const response = mainService();
    res.json(response);
});

// Health check controller
app.get('/health-check', (req, res) => {
    const response = healthCheckService();
    res.json(response);
});

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
});
