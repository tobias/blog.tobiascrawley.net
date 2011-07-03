require 'html_file'

Awestruct::Extensions::Pipeline.new do
  extension Awestruct::Extensions::Posts.new('/posts')
  extension Awestruct::Extensions::Paginator.new(:posts, '/index', :per_page => 5 )
  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::Atomizer.new(:posts, '/posts.atom')
  extension Awestruct::Extensions::Disqus.new()

  extension Awestruct::Extensions::Tagger.new( :posts, 
                                               '/index', 
                                               '/tags', 
                                               :per_page=>5 )

  extension Awestruct::Extensions::TagCloud.new( :posts, 
                                                 '/tags/index.html',
                                                 :layout=>'default' )


  helper Awestruct::Extensions::GoogleAnalytics
  helper Awestruct::Extensions::Partial
end
