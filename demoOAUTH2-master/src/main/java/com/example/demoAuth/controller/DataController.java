package com.example.demoAuth.controller;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.demoAuth.service.ApiService;
import java.util.Map;

@RestController
@RequestMapping("/api/data")
public class DataController {

	private final ApiService apiService;

	public DataController(ApiService apiService) {
		this.apiService = apiService;
	}

	@GetMapping("/hola")
	public Map<String, String> getHolaMundo(Authentication authentication) {
		Map<String, String> response = apiService.getHolaMundo();
		response.put("usuario", authentication.getName());
		return response;
	}
}
