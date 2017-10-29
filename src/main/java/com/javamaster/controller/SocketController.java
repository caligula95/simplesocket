package com.javamaster.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.javamaster.domain.User;

@Controller
public class SocketController {
	
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	@MessageMapping("/user/{name}")
	//@SendTo("/topic/users")
	public void showUsers(@DestinationVariable String name){
		System.out.println("Getting " + name);
		List<User> users = new ArrayList<User>();
		if (name!=null) {
			User user = new User();
			user.setName(name);
			users.add(user);
		}
		//return users;
		simpMessagingTemplate.convertAndSend("/topic/users", users);
	}

}
