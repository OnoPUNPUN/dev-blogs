import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:clean_architecture_project/core/usecase/usecase.dart';
import 'package:clean_architecture_project/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_project/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(params) async {
    return await blogRepository.getAllBlogs();
  }
}
