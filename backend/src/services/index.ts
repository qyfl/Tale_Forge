export * from './story.service'
export * from './user.service'
export * from './comment.service'
export * from './sync.service'


// 创建服务实例
import { StoryService } from './story.service'
import { UserService } from './user.service'
import { CommentService } from './comment.service'
import { AIService } from './ai.service'


export const storyService = new StoryService()
export const userService = new UserService()
export const commentService = new CommentService()
export const aiService = new AIService()