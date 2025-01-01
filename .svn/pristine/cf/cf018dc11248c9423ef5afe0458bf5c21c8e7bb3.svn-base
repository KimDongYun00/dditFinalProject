package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.mapper.ICourseMapper;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/chat")
@Slf4j
public class ChatHandler extends TextWebSocketHandler{

	
//	private Map<String, WebSocketSession> sessionMap;
	
	
	@Inject
	private ICourseMapper courseMapper;
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("afterConnectionEstablished("+session.getId()+")...!");
//		sessionMap.put(session.getId(), session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("handleTextMessage("+session+", "+message.getPayload()+")...!");

		JSONObject jsonObj = new JSONObject(message.getPayload());
		JSONObject jsonMsg = new JSONObject();
		String type = jsonObj.getString("type");
		
		if(type.equals("lecNow")) {
			List<Map<String, Object>> lecNowCntList = courseMapper.getAllLecNow();
			jsonMsg.put("type", "lecNow");
			jsonMsg.put("lecNowCntList", lecNowCntList);
			String strMsg = jsonMsg.toString();
			log.info("strMsg >> " + strMsg);
			session.sendMessage(new TextMessage(strMsg));
		} else if(type.equals("open")) {
			jsonMsg.put("type", "open");
			String strMsg = jsonMsg.toString();
			session.sendMessage(new TextMessage(strMsg));
		} else if(type.equals("course")) {
			String lecNo = jsonObj.getString("lecNo");
			int lecNow = courseMapper.getLecNowByLecNo(lecNo);
			int lecMax = courseMapper.getLecMaxByLecNo(lecNo);
			
			String result = "";
			if(lecNow < lecMax) {
				result = "Y";
			} else {
				result = "N";
			}
			
			jsonMsg.put("type", "course");
			jsonMsg.put("result", result);
			jsonMsg.put("lecNo", lecNo);
			String strMsg = jsonMsg.toString();
			session.sendMessage(new TextMessage(strMsg));
		} else {
			jsonMsg.put("type", "error");
			String strMsg = jsonMsg.toString();
			session.sendMessage(new TextMessage(strMsg));
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("afterConnectionClosed("+session.getId()+", "+status.toString()+")...!");
//		sessionMap.remove(session.getId(), session);
	}

	
	
	
	
	
}






























