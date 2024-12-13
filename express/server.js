import express from 'express';

const app = express();
const port = 3004;
const router = express.Router();
router.get("/", (req, res) => {
    res.json("안녕하세유");
})
app.use(router);
app.listen(port, () => {
    console.log(`서버가 ${port}번 포트에서 실행 중입니다.`);
});
