# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "粟田裕崇",
             email: "awata.hirotaka@lmi.ne.jp",
             password:              "20292872",
             password_confirmation: "20292872")
User.create!(name:  "石田静馬",
            email: "ishida.shizuma@lmi.ne.jp",
            password:              "20292872",
            password_confirmation: "20292872")



Item.create!(name: 'からくりサーカス１', price: '450', description: "遺産相続絡みで命を狙われる少年・勝と人を笑わせないと死んでしまう病にかかった男・鳴海、そして勝を助けるためにからくり人形を操る女・しろがね…。三人の運命が交錯する時、“笑顔”の本当の意味が…！？欧風熱血機巧活劇、ここに開幕！！", stock: 100, picture: 'karakuri1.jpg' )
Item.create!(name: 'からくりサーカス２', price: '450', description: "遺産相続で命を狙われる才賀勝が誘拐された！中国拳法の使い手・加藤鳴海と、からくり人形使いのしろがねは、勝を助けるために、才賀のからくり屋敷に向かうが、そこには様々な罠と、異様なからくり人形の数々が待ち受けており…！？", stock: 100, picture: 'karakuri2.jpg')
Item.create!(name: 'からくりサーカス３', price: '450', description: "誘拐された勝を助けようと奮闘する鳴海としろがね。しかし、才賀屋敷のからくりに行く手を阻まれ…！？一方、護られるだけだった勝は、ついに自らの意志で戦う決意を固める。時限爆弾の爆発が迫る中、三人の壮絶なる戦いの行方は…！？", stock: 100, picture: 'karakuri3.jpg')
Item.create!(name: 'からくりサーカス４', price: '450', description: "消えた鳴海の影を背負いつつ、新たなる一歩を踏み出した勝としろがね。しかし、追っ手の手はゆるまず、とんでもない誘拐事件が…！？そこへ現れたのは、仲町サーカスと名乗る面々。勝のクラスメートをも巻き込み、ハイウェイは大パニック！！", stock: 100, picture: 'karakuri4.jpg')
Item.create!(name: '鋼の錬金術師１', price: '400', description: "兄・エドワード・エルリック、弟・アルフォンス。2人の若き天才錬金術師は、幼いころ、病気で失った母を甦らせるため禁断の人体錬成を試みる。しかしその代償はあまりにも高すぎた…。錬成は失敗、エドワードはみずからの左足と、ただ一人の肉親・アルフォンスを失ってしまう。かけがえのない弟をこの世に呼び戻すため、エドワードは自身の右腕を代価とすることで、弟の魂を錬成し、鎧に定着させることに成功。そして兄弟は、すべてを取り戻すための長い旅に出る…。", stock: 100, picture: 'hagaren1.jpg')
Item.create!(name: '鋼の錬金術師２', price: '400', description: "東部辺境の町・リオール、炭鉱の町・ユースウェルを経て、東部の中心「イーストシティ」へと、エルリック兄弟の旅は続く。『焔の錬金術師』ロイ・マスタング大佐と軍の面々に迎えられた2人は、『綴命（ていめい）の錬金術師』タッカーと、その娘ニーナに出会う。そこでしだいに明らかになる、神に背きし者の背負いし罪と罰…。さらに“神の意思の代行者”をみずから任じ、国家錬金術師のみをつけ狙う宿敵『傷の男（スカー）』との遭遇!!　人ならざる存在であるラスト、グラトニーらも暗躍を開始し、物語は大きくうねり始める！", stock: 100, picture: 'hagaren2.jpg')
