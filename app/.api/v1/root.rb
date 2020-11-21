module V1
  class Root < Grape::API

    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    helpers do
      def authenticate_error!
        # 認証が失敗したときのエラー
        h = {'Access-Control-Allow-Origin' => "*", 
             'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",")}
        error!('You need to log in to use the app.', 401, h)
      end

      def authenticate_user!
        # header から認証に必要な情報を取得
        uid = request.headers['Uid']
        token = request.headers['Access-Token']
        client = request.headers['Client']
        @user = User.find_by_uid(uid)

        # 認証に失敗したらエラー
        unless @user && @user.valid_token?(token, client)
          authenticate_error!
        end
      end

    end

    desc 'GET /api/v1/test'
    get 'test' do
      authenticate_user!
      {message: 'test'}
    end

    desc 'GET /api/v1/hoge'
    get 'hoge' do
      {message: 'hoge'}
    end
    # サンプルなので、単純に root.rb に記述
  end
end