//日期选择器
  function selectDateNew(obj){
	  var myApp = new Framework7({
          fastClicks: false,
  });
	  var id = obj.id;
	  var today = new Date();
	  var pickerDate = myApp.picker({
		input: "#"+id,
		toolbarTemplate: '<div class="toolbar">' +
		  '<div class="toolbar-inner">' +
		  '<div class="left">' +
		  '<a href="#" class="link reset-picker">重设</a>' +
		  '</div>' +
		  '<div class="right">' +
		  '<a href="#" class="link close-picker">完成</a>' +
		  '</div>' +
		  '</div>' +
		  '</div>',

		//当触发的时候
		onOpen: function(picker, values, displayValues) {
		  //var todayArr = [today.getFullYear(), today.getMonth(), today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
		  var todayArr = [today.getFullYear(), today.getMonth()+1, today.getDate()];
		  picker.setValue(todayArr);
		  picker.container.find('.reset-picker').on('click', function() {
			picker.setValue(todayArr);
		  })
		},
		onChange: function(picker, values, displayValues) {
		  //获取当前月份的总天数
		  var daysInMonth = new Date(picker.value[0], picker.value[1] * 1, 0).getDate();
		  //如果设置月数大于当前月的总天数，设置天数为总天数
		  if (values[2] > daysInMonth) {
			picker.cols[2].setValue(daysInMonth);
		  }
		},
		//返回给input的格式，“-” 可以换成“年月日”
		formatValue: function(p, values, displayValues) {
		  return values[0] + '-' + values[1] + '-' + values[2];// + ',' + values[3] + ':' + values[4];
		},
		//返回 value数组
		cols: [
		  // 年
		  {
			values: (function() {
			  var arr = [];
			 var date = new Date();
			 newYear = date.getFullYear() + 15;
			  for (var i = 1990; i <= newYear; i++) {
				arr.push(i);
			  }
			  return arr;
			})(),
		  },
		  // 月
		  {
			values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
		  },
		  // 日
		  {
			values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
		  },
		  // 空格
		  {
			divider: true,
			content: ' '
		  }//,
		  // 时
		  /*{
			values: (function() {
			  var arr = [];
			  for (var i = 0; i <= 23; i++) {
				arr.push(i);
			  }
			  return arr;
			})(),
		  },
		  // 冒号
		  {
			divider: true,
			content: ':'
		  },
		  // 分
		  {
			values: (function() {
			  var arr = [];
			  for (var i = 0; i <= 59; i++) {
				arr.push(i < 10 ? '0' + i : i);
			  }
			  return arr;
			})(),
		  }*/
		]
	  });
      myApp = null;   
  }
	
	//时分选择器
  function selectTimeNew(obj){
	  var myApp = new Framework7({
          fastClicks: false,
  });
	  var id = obj.id;
	  var today = new Date();
	  var pickerDate = myApp.picker({
		input: '#'+id,
		toolbarTemplate: '<div class="toolbar">' +
		  '<div class="toolbar-inner">' +
		  '<div class="left">' +
		  '<a href="#" class="link reset-picker">重设</a>' +
		  '</div>' +
		  '<div class="right">' +
		  '<a href="#" class="link close-picker">完成</a>' +
		  '</div>' +
		  '</div>' +
		  '</div>',

		//当触发的时候
		onOpen: function(picker, values, displayValues) {
		  //var todayArr = [today.getFullYear(), today.getMonth(), today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
		  var todayArr = [today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
		  picker.setValue(todayArr);
		  picker.container.find('.reset-picker').on('click', function() {
			picker.setValue(todayArr);
		  })
		},
		onChange: function(picker, values, displayValues) {
		  //获取当前月份的总天数
		  var daysInMonth = new Date(picker.value[0], picker.value[1] * 1, 0).getDate();
		  //如果设置月数大于当前月的总天数，设置天数为总天数
		  if (values[2] > daysInMonth) {
			picker.cols[2].setValue(daysInMonth);
		  }
		},
		//返回给input的格式，“-” 可以换成“年月日”
		formatValue: function(p, values, displayValues) {
		  return values[0] + ':' + values[1];
		},
		//返回 value数组
		cols: [     
		  {
			values: (function() {
			  var arr = [];
			  for (var i = 0; i <= 23; i++) {
				arr.push(i);
			  }
			  return arr;
			})(),
		  },
		  // 冒号
		  {
			divider: true,
			content: ':'
		  },
		  // 分
		  {
			values: (function() {
			  var arr = [];
			  for (var i = 0; i <= 59; i++) {
				arr.push(i < 10 ? '0' + i : i);
			  }
			  return arr;
			})(),
		  }
		]
	  });
    }
//日期时分选择器
  function selectDateTimeNew(obj){
	  var myApp = new Framework7({
          fastClicks: false,
      });
		 
	  var id = obj.id;
	  var today = new Date();
	  var pickerDate = myApp.picker({
		input: "#"+id,
		toolbarTemplate: '<div class="toolbar">' +
		  '<div class="toolbar-inner">' +
		  '<div class="left">' +
		  '<a href="#" class="link reset-picker">重设</a>' +
		  '</div>' +
		  '<div class="right">' +
		  '<a href="#" class="link close-picker">完成</a>' +
		  '</div>' +
		  '</div>' +
		  '</div>',

		//当触发的时候
		onOpen: function(picker, values, displayValues) {
		  var todayArr = [today.getFullYear(), today.getMonth()+1, today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
		  picker.setValue(todayArr);
		  picker.container.find('.reset-picker').on('click', function() {
			picker.setValue(todayArr);
		  })
		},
		onChange: function(picker, values, displayValues) {
		  //获取当前月份的总天数
		  var daysInMonth = new Date(picker.value[0], picker.value[1] * 1, 0).getDate();
		  //如果设置月数大于当前月的总天数，设置天数为总天数
		  if (values[2] > daysInMonth) {
			picker.cols[2].setValue(daysInMonth);
		  }
		},
		//返回给input的格式，“-” 可以换成“年月日”
		formatValue: function(p, values, displayValues) {
		  return values[0] + '-' + values[1] + '-' + values[2] + ',' + values[3] + ':' + values[4];
		},
		//返回 value数组
		cols: [
		  // 年
		  {
			values: (function() {
			  var arr = [];
			 var date = new Date();
			 newYear = date.getFullYear() + 15;
			  for (var i = 1990; i <= newYear; i++) {
				arr.push(i);
			  }
			  return arr;
			})(),
		  },
		  // 月
		  {
			values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
		  },
		  // 日
		  {
			values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
		  },
		  // 空格
		  {
			divider: true,
			content: ' '
		  },
		  // 时
		  {
			values: (function() {
			  var arr = [];
			  for (var i = 0; i <= 23; i++) {
				arr.push(i);
			  }
			  return arr;
			})(),
		  },
		  // 冒号
		  {
			divider: true,
			content: ':'
		  },
		  // 分
		  {
			values: (function() {
			  var arr = [];
			  for (var i = 0; i <= 59; i++) {
				arr.push(i < 10 ? '0' + i : i);
			  }
			  return arr;
			})(),
		  }
		]
	  });
  }