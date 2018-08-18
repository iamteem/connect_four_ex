import {Socket} from "phoenix";
const userToken = document.head.querySelector("[name=channel_token]").content;
let socket = new Socket("/socket", {params: {token: userToken}});
socket.connect();
export default socket;
