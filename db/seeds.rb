# config: utf-8

users = [
  {name: '山田花子', email: 'yamada@example.com', validate_password: '12345678'},
  {name: '鈴木誠也', email: 'suzuki@example.com', validate_password: '12345678'},
  {name: '田中太郎', email: 'tanaka@example.com', validate_password: '12345678'},
  {name: '佐藤久美子', email: 'satou@example.com', validate_password: '12345678'},
  {name: '高橋洋二', email: 'takahashi@example.com', validate_password: '12345678'},
  {name: '遠藤秀夫', email: 'endou@example.com', validate_password: '12345678'},
  {name: '斎藤一', email: 'saitou@example.com', validate_password: '12345678'},
  {name: '野口英男', email: 'noguti@example.com', validate_password: '12345678'},
  {name: 'トラン・アン・ティエン', email: 'toran@example.com', validate_password: '12345678'},
  {name: '山口高貴', email: 'yamaguti@example.com', validate_password: '12345678'},
]
jack = User.create!(name: 'ジャック・ゴールドマン', email: 'jack@example.com', validate_password: '12345678')

users.map! do |u|
  User.create!(u)
end

group = Group.create!(name: '神戸電子専門学校', detail:'神戸電子のグループです。', private: true, password: '12345678', author: users.first)

1.upto 10 do |i|
  Group.create!(name: "Test#{format('%02d', i)}", detail: 'This is test group', private: i != 10, password: i != 10 ? '12345678' : nil, author: jack)
end

group.members = users
group.users_groups[0].admin = true
group.users_groups[0].save!
group.users_groups[1].admin = true
group.users_groups[1].save!
group.users_groups[2].admin = true
group.users_groups[2].save!

1.upto 10 do |i|
  kanzi_detail = <<~EOS
    漢字ドリルの宿題。丁寧な字で書くこと！

    提出:
    朝のホームルームまでに先生の机
  EOS
  sansu_detail = <<~EOS
    算数ドリルの宿題。答え合わせもすること。
    授業の初めに回収します。
  EOS
  rika_detail = <<~EOS
    理科のプリント。夏休み明けテストします。
    期限までにプリント係に渡してください。
  EOS
  t = Task.create!(title: "漢字ドリル #{i}p", detail: kanzi_detail, deadline: 10.days.since, points: i * 100, importance: i, author: group.users_groups[0].user, group: group)
  for i in 0...(group.not_admins.length / 2)
    UsersTask.create!(user: group.not_admins[i], task: t, state: UsersTask::STATE_UNFINISHED)
  end
  for i in (group.not_admins.length / 2 + 1)...(group.not_admins.length)
    UsersTask.create!(user: group.not_admins[i], task: t, state: UsersTask::STATE_FINISHED, finished_at: Date.current)
  end
  t = Task.create!(title: "算数ドリル #{i}p", detail: sansu_detail, deadline: 5.days.since, points: i * 100, importance: i, author: group.users_groups[1].user, group: group)
  for i in 0...(group.not_admins.length / 2)
    UsersTask.create!(user: group.not_admins[i], task: t, state: UsersTask::STATE_FINISHED, finished_at: Date.current)
  end
  for i in (group.not_admins.length / 2 + 1)...(group.not_admins.length)
    UsersTask.create!(user: group.not_admins[i], task: t, state: UsersTask::STATE_UNFINISHED)
  end
  t = Task.create!(title: "理科のプリント #{i}枚目", detail: rika_detail, deadline: 5.days.ago, points: i * 10, importance: i, author: group.users_groups[2].user, group: group)
  group.not_admins.each do |u|
    UsersTask.create!(user: u, task: t, state: UsersTask::STATE_CONFIRMED, finished_at: 10.days.ago)
  end
end
group.not_admins.each do |u|
  ug = UsersGroup.where(group: group).where(user: u).first
  ug.total_points = 10 * rand(200)
  ug.save!
end

grades = [
  {name: '訓練兵', necessary_points: '0'},
  {name: '二等兵', necessary_points: '100'},
  {name: '一等兵', necessary_points: '200'},
  {name: '上等兵', necessary_points: '350'},
  {name: '兵長', necessary_points: '500'},
  {name: '伍長', necessary_points: '750'},
  {name: '軍曹', necessary_points: '1000'},
  {name: '曹長', necessary_points: '1200'},
  {name: '少尉', necessary_points: '1400'},
  {name: '中尉', necessary_points: '1700'},
  {name: '大尉', necessary_points: '2000'},
  {name: '少佐', necessary_points: '2400'},
  {name: '中佐', necessary_points: '2800'},
  {name: '大佐', necessary_points: '3300'},
  {name: '准将', necessary_points: '3800'},
  {name: '少将', necessary_points: '4450'},
  {name: '中将', necessary_points: '5000'},
  {name: '大将', necessary_points: '6000'},
  {name: '元帥', necessary_points: '10000'}
]

grades.each do |g|
  g.store(:group, group)
  Grade.create!(g)
end
