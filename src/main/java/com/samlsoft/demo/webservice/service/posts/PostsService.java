package com.samlsoft.demo.webservice.service.posts;

import com.samlsoft.demo.webservice.domain.posts.Posts;
import com.samlsoft.demo.webservice.domain.posts.PostsRepository;
import com.samlsoft.demo.webservice.web.dto.PostsResponseDto;
import com.samlsoft.demo.webservice.web.dto.PostsSaveRequestDto;
import com.samlsoft.demo.webservice.web.dto.PostsUpdateRequestDto;
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

    public PostsResponseDto findById(Long id) {
        Posts posts = postsRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습니다. id=" + id));
        PostsResponseDto postsResponseDto = new PostsResponseDto(posts);
        return postsResponseDto;
    }

    @Transactional
    public Long update(Long id, PostsUpdateRequestDto requestDto) {
        Posts posts = postsRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습ㄴ디ㅏ. id="+id));
        posts.update(requestDto.getTitle(),requestDto.getContent());
        return id;
    }
}
