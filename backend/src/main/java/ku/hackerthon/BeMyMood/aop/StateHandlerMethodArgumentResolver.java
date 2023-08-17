package ku.hackerthon.BeMyMood.aop;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.service.auth.state.StateManager;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

/**
 * {@link ku.hackerthon.BeMyMood.config.WebConfig}
 */
@Slf4j
@RequiredArgsConstructor
@Component
public class StateHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver {

    private final StateManager<String, Long> stateManager;

    /**
     * {@link State} 애노테이션이 붙은 메서드 파라미터 대상
     * @param parameter the method parameter to check
     * @return
     */
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        boolean isStateAnnotated = parameter.getParameterAnnotation(State.class) != null;
        boolean isLongClass = Long.class.equals(parameter.getParameterType());
        return isStateAnnotated && isLongClass;
    }

    /**
     * 파라미터에 StoreManager에 저장된 MemberId를 넣어준다.
     */
    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        String sessionId = RequestContextHolder.getRequestAttributes().getSessionId();
        log.info("access session : {} | member-id : {}", sessionId, stateManager.get(sessionId));
        return stateManager.get(sessionId);
    }
}
