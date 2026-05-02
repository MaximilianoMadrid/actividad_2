package com.example.demoAuth.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class ApiService {

	private final RestTemplate restTemplate;

	public ApiService(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	public Map<String, String> getHolaMundo() {
		try {
			// Consumir una API REST gratuita como ejemplo
			String url = "https://jsonplaceholder.typicode.com/posts/1";
			Map<String, Object> response = restTemplate.getForObject(url, Map.class);
			
			// Construir respuesta con "Hola Mundo"
			Map<String, String> result = new LinkedHashMap<>();
			result.put("mensaje", "Hola Mundo");
			result.put("timestamp", java.time.Instant.now().toString());
			result.put("apiExterna", "JSONPlaceholder");
			result.put("estado", "autenticado");
			
			return result;
		} catch (Exception e) {
			Map<String, String> error = new LinkedHashMap<>();
			error.put("error", "No se pudo consumir la API externa");
			error.put("detalle", e.getMessage());
			return error;
		}
	}
}
