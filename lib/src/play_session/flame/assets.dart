// player|8,8;1,0;4,1;4,0;6,1;1,0;2,1;1,0;2,1;1,0;4,1;2,0;1,1;2,0;9,1;1,0;6,1;2,0;1,1;3,0;1,1;3,0;2,1;2,0;2,1;1,0
// bullet|8,8;3,0;2,1;4,0;6,1;2,0;6,1;1,0;16,1;1,0;6,1;2,0;6,1;4,0;2,1;3,0
// player1|8,8;7,0;1,1;6,0;1,1;6,0;1,1;5,0;2,1;5,0;1,1;1,0;2,1;3,0;1,1;2,0;3,1;1,0;3,1;1,0;6,1;3,0;3,1
// player2|8,8;1,1;8,0;1,1;8,0;1,1;8,0;2,1;5,0;1,1;2,0;1,1;3,0;3,1;1,0;2,1;1,0;3,1;1,0;7,1;2,0;3,1

final libraryAsset =
    '''groundblock|8,8;18,1;4,0;4,1;1,0;2,1;1,0;4,1;1,0;2,1;1,0;4,1;4,0;10,1;1,0;6,1;1,0
blockplayer|8,8;1,0;6,1;1,0;9,1;1,0;3,1;1,0;3,1;2,0;2,1;2,0;19,1;4,0;2,1;1,0;6,1;1,0
towerbottom|8,8;9,1;6,0;1,1;1,0;1,1;4,0;1,1;2,0;1,1;4,0;1,1;3,0;1,1;2,0;1,1;4,0;1,1;2,0;1,1;4,0;1,1;2,0;1,1;5,0;2,1;3,0
towerblock|8,8;1,0;6,1;1,0;2,1;4,0;3,1;1,0;1,1;2,0;1,1;1,0;2,1;2,0;2,1;2,0;2,1;2,0;2,1;2,0;2,1;1,0;1,1;2,0;1,1;1,0;3,1;4,0;2,1;1,0;6,1;1,0
finish|8,8;1,1;1,0;1,1;1,0;1,1;1,0;1,1;2,0;1,1;1,0;1,1;1,0;1,1;1,0;2,1;1,0;1,1;1,0;1,1;1,0;1,1;2,0;1,1;1,0;1,1;1,0;1,1;1,0;2,1;6,0;2,1;6,0;2,1;6,0;2,1;6,0;1,1
leftcap|8,8;2,0;6,1;1,0;9,1;4,0;4,1;1,0;2,1;1,0;4,1;1,0;2,1;1,0;4,1;4,0;2,1;1,0;7,1;2,0;5,1;1,0
rightcap|8,8;6,1;2,0;7,1;1,0;2,1;4,0;4,1;1,0;2,1;1,0;4,1;1,0;2,1;1,0;4,1;4,0;9,1;2,0;5,1;2,0
''';

final maps = <String, String>{
  'map1':
      '''[{"x":0,"y":9,"data":{"sprite":"leftcap"}},{"x":1,"y":9,"data":{"sprite":"groundblock"}},{"x":2,"y":9,"data":{"sprite":"groundblock"}},{"x":3,"y":9,"data":{"sprite":"groundblock"}},{"x":4,"y":9,"data":{"sprite":"groundblock"}},{"x":5,"y":9,"data":{"sprite":"groundblock"}},{"x":6,"y":9,"data":{"sprite":"groundblock"}},{"x":7,"y":9,"data":{"sprite":"groundblock"}},{"x":8,"y":9,"data":{"sprite":"groundblock"}},{"x":9,"y":9,"data":{"sprite":"groundblock"}},{"x":10,"y":9,"data":{"sprite":"groundblock"}},{"x":11,"y":9,"data":{"sprite":"groundblock"}},{"x":12,"y":9,"data":{"sprite":"groundblock"}},{"x":13,"y":9,"data":{"sprite":"groundblock"}},{"x":14,"y":9,"data":{"sprite":"groundblock"}},{"x":15,"y":9,"data":{"sprite":"groundblock"}},{"x":16,"y":9,"data":{"sprite":"groundblock"}},{"x":17,"y":9,"data":{"sprite":"groundblock"}},{"x":18,"y":9,"data":{"sprite":"rightcap"}},{"x":1,"y":8,"data":{"sprite":"towerbottom"}},{"x":5,"y":8,"data":{"sprite":"towerbottom"}},{"x":9,"y":8,"data":{"sprite":"towerbottom"}},{"x":13,"y":8,"data":{"sprite":"towerbottom"}},{"x":17,"y":8,"data":{"sprite":"towerbottom"}},{"x":1,"y":7,"data":{"sprite":"towerblock"}},{"x":1,"y":6,"data":{"sprite":"towerblock"}},{"x":5,"y":7,"data":{"sprite":"towerblock"}},{"x":5,"y":6,"data":{"sprite":"towerblock"}},{"x":9,"y":7,"data":{"sprite":"towerblock"}},{"x":9,"y":6,"data":{"sprite":"towerblock"}},{"x":13,"y":7,"data":{"sprite":"towerblock"}},{"x":13,"y":6,"data":{"sprite":"towerblock"}},{"x":17,"y":7,"data":{"sprite":"towerblock"}},{"x":17,"y":6,"data":{"sprite":"towerblock"}},{"x":17,"y":5,"data":{"sprite":"finish"}},{"x":1,"y":5,"data":{"sprite":"blockplayer"}}]''',
  'map2':
      '''[{"x":0,"y":9,"data":{"sprite":"leftcap"}},{"x":1,"y":9,"data":{"sprite":"groundblock"}},{"x":2,"y":9,"data":{"sprite":"groundblock"}},{"x":3,"y":9,"data":{"sprite":"groundblock"}},{"x":4,"y":9,"data":{"sprite":"groundblock"}},{"x":5,"y":9,"data":{"sprite":"groundblock"}},{"x":6,"y":9,"data":{"sprite":"groundblock"}},{"x":7,"y":9,"data":{"sprite":"groundblock"}},{"x":8,"y":9,"data":{"sprite":"groundblock"}},{"x":9,"y":9,"data":{"sprite":"groundblock"}},{"x":10,"y":9,"data":{"sprite":"groundblock"}},{"x":11,"y":9,"data":{"sprite":"groundblock"}},{"x":12,"y":9,"data":{"sprite":"groundblock"}},{"x":13,"y":9,"data":{"sprite":"groundblock"}},{"x":14,"y":9,"data":{"sprite":"groundblock"}},{"x":15,"y":9,"data":{"sprite":"groundblock"}},{"x":16,"y":9,"data":{"sprite":"groundblock"}},{"x":17,"y":9,"data":{"sprite":"groundblock"}},{"x":18,"y":9,"data":{"sprite":"rightcap"}},{"x":1,"y":8,"data":{"sprite":"towerbottom"}},{"x":5,"y":8,"data":{"sprite":"towerbottom"}},{"x":9,"y":8,"data":{"sprite":"groundblock"}},{"x":13,"y":8,"data":{"sprite":"towerbottom"}},{"x":17,"y":8,"data":{"sprite":"towerbottom"}},{"x":1,"y":7,"data":{"sprite":"towerblock"}},{"x":1,"y":6,"data":{"sprite":"towerblock"}},{"x":5,"y":7,"data":{"sprite":"towerblock"}},{"x":5,"y":6,"data":{"sprite":"towerblock"}},{"x":13,"y":7,"data":{"sprite":"towerblock"}},{"x":13,"y":6,"data":{"sprite":"towerblock"}},{"x":17,"y":7,"data":{"sprite":"towerblock"}},{"x":1,"y":5,"data":{"sprite":"blockplayer"}},{"x":8,"y":8,"data":{"sprite":"groundblock"}},{"x":7,"y":8,"data":{"sprite":"groundblock"}},{"x":10,"y":8,"data":{"sprite":"groundblock"}},{"x":11,"y":8,"data":{"sprite":"groundblock"}},{"x":17,"y":6,"data":{"sprite":"towerblock"}},{"x":17,"y":5,"data":{"sprite":"finish"}},{"x":9,"y":7,"data":{"sprite":"towerbottom"}},{"x":9,"y":6,"data":{"sprite":"towerblock"}}]''',
  'map3':
      '''[{"x":0,"y":9,"data":{"sprite":"leftcap"}},{"x":1,"y":9,"data":{"sprite":"groundblock"}},{"x":2,"y":9,"data":{"sprite":"groundblock"}},{"x":3,"y":9,"data":{"sprite":"groundblock"}},{"x":1,"y":8,"data":{"sprite":"towerbottom"}},{"x":3,"y":8,"data":{"sprite":"towerbottom"}},{"x":3,"y":7,"data":{"sprite":"towerblock"}},{"x":4,"y":9,"data":{"sprite":"groundblock"}},{"x":5,"y":9,"data":{"sprite":"groundblock"}},{"x":6,"y":9,"data":{"sprite":"groundblock"}},{"x":6,"y":8,"data":{"sprite":"towerbottom"}},{"x":6,"y":7,"data":{"sprite":"towerblock"}},{"x":6,"y":6,"data":{"sprite":"towerblock"}},{"x":7,"y":8,"data":{"sprite":"groundblock"}},{"x":8,"y":7,"data":{"sprite":"groundblock"}},{"x":8,"y":6,"data":{"sprite":"towerbottom"}},{"x":10,"y":6,"data":{"sprite":"towerbottom"}},{"x":9,"y":7,"data":{"sprite":"groundblock"}},{"x":10,"y":7,"data":{"sprite":"groundblock"}},{"x":11,"y":8,"data":{"sprite":"groundblock"}},{"x":12,"y":9,"data":{"sprite":"groundblock"}},{"x":13,"y":9,"data":{"sprite":"groundblock"}},{"x":13,"y":8,"data":{"sprite":"towerblock"}},{"x":14,"y":9,"data":{"sprite":"groundblock"}},{"x":15,"y":9,"data":{"sprite":"groundblock"}},{"x":13,"y":7,"data":{"sprite":"towerblock"}},{"x":16,"y":8,"data":{"sprite":"towerbottom"}},{"x":16,"y":7,"data":{"sprite":"towerblock"}},{"x":16,"y":9,"data":{"sprite":"groundblock"}},{"x":17,"y":9,"data":{"sprite":"groundblock"}},{"x":18,"y":9,"data":{"sprite":"groundblock"}},{"x":19,"y":9,"data":{"sprite":"groundblock"}},{"x":19,"y":8,"data":{"sprite":"towerbottom"}},{"x":19,"y":7,"data":{"sprite":"towerblock"}},{"x":19,"y":6,"data":{"sprite":"towerblock"}},{"x":20,"y":9,"data":{"sprite":"groundblock"}},{"x":21,"y":9,"data":{"sprite":"groundblock"}},{"x":22,"y":9,"data":{"sprite":"groundblock"}},{"x":23,"y":9,"data":{"sprite":"groundblock"}},{"x":24,"y":9,"data":{"sprite":"groundblock"}},{"x":24,"y":8,"data":{"sprite":"towerblock"}},{"x":25,"y":9,"data":{"sprite":"groundblock"}},{"x":28,"y":9,"data":{"sprite":"groundblock"}},{"x":29,"y":9,"data":{"sprite":"rightcap"}},{"x":27,"y":9,"data":{"sprite":"groundblock"}},{"x":26,"y":9,"data":{"sprite":"groundblock"}},{"x":28,"y":8,"data":{"sprite":"towerbottom"}},{"x":28,"y":7,"data":{"sprite":"finish"}},{"x":1,"y":7,"data":{"sprite":"blockplayer"}}]''',
};
