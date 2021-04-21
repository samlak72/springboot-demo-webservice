package com.samlsoft.demo.webservice.service.posts;

import com.samlsoft.demo.webservice.domain.posts.Posts;
import com.samlsoft.demo.webservice.domain.posts.PostsRepository;
import com.samlsoft.demo.webservice.web.dto.PostsSaveRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@RequiredArgsConstructor
@Service
public class PostsService {

    @Autowired
    private PostsRepository postsRepository;

    @Transactional
    public Long save(PostsSaveRequestDto requestDto) {
        return postsRepository.save(requestDto.toEntity()).getId();
    }
}
