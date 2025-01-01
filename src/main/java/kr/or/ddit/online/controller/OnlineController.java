package kr.or.ddit.online.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.ddit.service.admin.inter.IAdminLectureService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Controller
@Slf4j
@RequestMapping("/online")
public class OnlineController {

	@Inject
	private IAdminLectureService lecService;
	
	@RequestMapping(value="/onlineLecture", method = RequestMethod.GET)
	public String onlineLecture(
			String lecNo, Model model) {
		LectureVO lecVO = lecService.getLectureByLecNo(lecNo);
		model.addAttribute("lecVO", lecVO);
		return "sum/online/onlineLecture";
	}
	
	@RequestMapping(value="/onlineConsulting", method = RequestMethod.GET)
	public String onlineConsulting(
			String conNo, Model model) {
		model.addAttribute("conNo", conNo);
		return "sum/online/onlineConsulting";
	}
	
	@ResponseBody
	@RequestMapping(value = "/createRoom", method = RequestMethod.POST)
	public String createRoom(
			String roomTitle
			,String maxJoinCount
			,String durationMinutes
			) throws Exception {
		OkHttpClient client = new OkHttpClient();
		log.info("roomTitle >" + roomTitle);
		roomTitle = URLEncoder.encode(roomTitle, "UTF-8");
		log.info("roomTitle >" + roomTitle);

		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		RequestBody body = RequestBody.create(mediaType, 
				"callType=P2P&liveMode=false&maxJoinCount=4&liveMaxJoinCount=100&layoutType=4&sfuIncludeAll=true"
				+"&roomTitle="+roomTitle+"&maxJoinCount="+maxJoinCount+"&durationMinutes="+durationMinutes);
		Request request = new Request.Builder()
		  .url("https://openapi.gooroomee.com/api/v1/room")
		  .post(body)
		  .addHeader("accept", "application/json")
		  .addHeader("content-type", "application/x-www-form-urlencoded")
		  .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
		  .build();

		Response response = client.newCall(request).execute();
		return response.body().string();
	}
	
	@ResponseBody
	@RequestMapping(value = "/roomList", method = RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> roomList() throws Exception {
		OkHttpClient client = new OkHttpClient();

		Request request = new Request.Builder()
		  .url("https://openapi.gooroomee.com/api/v1/room/list?page=1&limit=10&sortCurrJoinCnt=true")
		  .get()
		  .addHeader("accept", "application/json")
		  .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
		  .build();
		
		Response response = client.newCall(request).execute();
		JsonParser parser = new JsonParser();
		JsonObject jsonObj = (JsonObject) parser.parse(response.body().string());
		
		JsonObject dataObj = jsonObj.get("data").getAsJsonObject();
		JsonArray listArr = dataObj.get("list").getAsJsonArray();
		
		List<Map<String, Object>> dataList = new ArrayList<Map<String,Object>>();
		for(int i = 0; i < listArr.size(); i++) {
			
			JsonObject data = listArr.get(i).getAsJsonObject();
			Map<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("roomId", data.get("roomId").getAsString());
			String tempTitle = data.get("roomTitle").isJsonNull() ? null : data.get("roomTitle").getAsString();
			dataMap.put("roomTitle", tempTitle);
			dataMap.put("maxJoinCnt", data.get("maxJoinCnt").getAsInt());
			dataMap.put("currJoinCnt", data.get("currJoinCnt").getAsInt());
			dataMap.put("startDate", data.get("startDate").getAsString());
			dataMap.put("endDate", data.get("endDate").getAsString());
			dataList.add(dataMap);
		}
		return new ResponseEntity<List<Map<String, Object>>>(dataList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/enterRoom", method = RequestMethod.POST)
	public String enterRoom(String roomId, String username, String userid) throws Exception {

		CustomUser user =  (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		
		String roleId = "participant";
		if(userVO.getComDetUNo().equals("U0102")) {
			roleId = "speaker";
		}
		
		OkHttpClient client = new OkHttpClient();
		
		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		RequestBody body = RequestBody.create(mediaType, "roleId="+roleId+"&apiUserId="+userid+"&ignorePasswd=false&roomId="+roomId+"&username="+username);
		Request request = new Request.Builder()
		  .url("https://openapi.gooroomee.com/api/v1/room/user/otp/url")
		  .post(body)
		  .addHeader("accept", "application/json")
		  .addHeader("content-type", "application/x-www-form-urlencoded")
		  .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
		  .build();

		Response response = client.newCall(request).execute();
		return response.body().string();
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteRoom", method = RequestMethod.POST)
	public String deleteRoom(String roomId) throws Exception {
		OkHttpClient client = new OkHttpClient();

		Request request = new Request.Builder()
		  .url("https://openapi.gooroomee.com/api/v1/room/"+roomId)
		  .delete(null)
		  .addHeader("accept", "application/json")
		  .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
		  .build();

		Response response = client.newCall(request).execute();
		return response.body().string();
	}
	
	
	
	
	
	
	
	
}


























