package com.plutus.app.service;

import com.plutus.app.dto.UserDto;
import com.plutus.app.entity.User;
import com.plutus.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public User registerUser(UserDto userDto) {
        String username = userDto.getUsername();
        String pwd = userDto.getPassword();
        String email = userDto.getEmail();

        // Check if the email is already registered
        if (userRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("Email is already registered");
        }

        LocalDateTime now = LocalDateTime.now();
        User user = User.builder()
            .username(username)
            .pwd(pwd)
            .email(email)
            .createdAt(now)
            .updatedAt(now)
            .build();

        if (user == null) {
            throw new IllegalArgumentException("User cannot be null");
        }

        return userRepository.save(user);
    }
}