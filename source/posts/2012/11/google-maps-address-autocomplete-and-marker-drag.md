---
title: Google Maps 搜索建议和地标拖动示例
slug: google-maps-address-autocomplete-and-marker-drag
date: 2012-11-16 00:24
tags: [google-maps]
---

**功能：** 通过输入框输入联想地址，选择地址后在地图中添加地标，地标可以拖动以细调 LatLng 
（与豆瓣的[发动活动][1]的功能类似)

因为 [ScriptFan][2] 官网开发中需要选择活动地点的功能，所以开发了这个例子，参考了 Google 官方示例 
[Google Maps JavaScript API v3 Example: Marker Animations][3] ，并参考 **力王(@LeeWong)** 同学的[代码][4]，
增加了相对当前地图范围的搜索建议。

在线演示 <http://greatghoul.github.com/google-maps-samples/address-marker/>

![Picture](https://s.yunio.com/public/previews/token/eqakOv/size/700/?r=a.jpg)

设置自动完成搜索建议控件
------------------------

    // Initialize autocomplete instance
    var ac_options = {
      bounds: map.getBounds(),
      types: ['establishment']
    };
    input_address = document.getElementById('address');
    autocomplete = new google.maps.places.Autocomplete(input_address, ac_options);
    autocomplete.bindTo('bounds', map);
    autocomplete.addListener('place_changed', place_changed);


`autocomplete.addListener('place_changed', place_changed);` 可以监听地址的选择事件，在地址变更后，更新地标、
居中地图并显示坐标。

    function place_changed() {
        var position = autocomplete.getPlace().geometry.location;
        show_position(position);
        marker.setPosition(position);
        marker.setMap(map);
        // map.setCenter(position);
        map.panTo(position);
    }

使用 `map.panTo(position);` 可以在跳转地图地点时平常移动。

设置地标
----------

    // Initialize marker instance
    marker = new google.maps.Marker({
        // map:map,
        draggable: true,
        animation: google.maps.Animation.DROP
        // position: xian
    });
    marker.addListener('dragend', marker_dragend);
    google.maps.event.addListener(marker, 'click', toggle_bounce);</pre>

使用 `marker.addListener('dragend', marker_dragend);` 可以监听地标的拖动事件，在拖动结束后可以更新坐标。

    function marker_dragend() {
        var position = marker.getPosition();
        show_position(position);
        // map.setCenter(position);
        map.panTo(position); // smoothly
    }

使用 `google.maps.event.addListener(marker, 'click', toggle_bounce);` 可以监听地点的点击事件，从而可以显示信息或者显示
标的跳动动画效果。

    function toggle_bounce() {
        if (marker.getAnimation() != null) {
            marker.setAnimation(null);
        } else {
            marker.setAnimation(google.maps.Animation.BOUNCE);
        }
    }

参考资料：
------------

 - [google.maps.Marker][r1]
 - [Google Maps JavaScript API v3 Example: Marker Animations][r2]
 - [google.maps.places.Autocomplete][r3]
 - [CoordinateCatcher][r4]

目地址： <https://github.com/greatghoul/google-maps-samples>

[1]: http://www.douban.com/event/create?loc=xian
[2]: https://github.com/kingheaven/ScriptFan.com
[3]: https://google-developers.appspot.com/maps/documentation/javascript/examples/marker-animations
[4]: http://leewonggit.github.com/CoordinateCatcher/

[r1]: https://developers.google.com/maps/documentation/javascript/reference#Marker
[r2]: https://google-developers.appspot.com/maps/documentation/javascript/examples/marker-animations
[r3]: https://developers.google.com/maps/documentation/javascript/reference#Autocomplete
[r4]: http://leewonggit.github.com/CoordinateCatcher/
