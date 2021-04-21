package com.samlsoft.demo.webservice.web;

import com.samlsoft.demo.webservice.domain.posts.PostsRepository;
import com.samlsoft.demo.webservice.service.posts.PostsService;
import com.samlsoft.demo.webservice.web.dto.PostsSaveRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
public class PostsApiController {

    private final PostsService postsService;

    @PostMapping("/api/v1/posts")
    public Long save(@RequestBody PostsSaveRequestDto requestDto) {
        return postsService.save(requestDto);
    }
}
