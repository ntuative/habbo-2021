package login
{
    import flash.display.Sprite;
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;
    import flash.display.Bitmap;
    import flash.text.TextField;
    import onBoardingHcUi.Button;
    import flash.utils.Timer;
    import flash.events.Event;
    import onBoardingHcUi.LoaderUI;
    import flash.events.TimerEvent;
    import onBoardingHcUi.ColouredButton;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;

    public class EnvironmentView extends Sprite implements IDisposable
    {

        private static const flag_icon_de_png:Class = HabboEnvironmentView_flag_icon_de_png;
        private static const flag_icon_dev_png:Class = HabboEnvironmentView_flag_icon_dev_png;
        private static const flag_icon_en_png:Class = HabboEnvironmentView_flag_icon_en_png;
        private static const flag_icon_es_png:Class = HabboEnvironmentView_flag_icon_es_png;
        private static const flag_icon_fi_png:Class = HabboEnvironmentView_flag_icon_fi_png;
        private static const flag_icon_fr_png:Class = HabboEnvironmentView_flag_icon_fr_png;
        private static const flag_icon_it_png:Class = HabboEnvironmentView_flag_icon_it_png;
        private static const flag_icon_nl_png:Class = HabboEnvironmentView_flag_icon_nl_png;
        private static const flag_icon_pt_png:Class = HabboEnvironmentView_flag_icon_pt_png;
        private static const flag_icon_tr_png:Class = HabboEnvironmentView_flag_icon_tr_png;
        private static const flag_icon_selected_png:Class = HabboEnvironmentView_flag_icon_selected_png;
        private static const ITEMS_PER_ROW:int = 9;
        private static const THUMB_SIZE:int = 160;
        private static const THUMB_SCALE:Number = 0.5;
        private static const SPACING:int = 10;

        private var _SafeStr_4554:Vector.<Bitmap>;
        private var _context:LoginFlow;
        private var _SafeStr_4547:TextField;
        private var _SafeStr_4555:Bitmap;
        private var _environmentName:TextField;
        private var _SafeStr_4556:int = 0;
        private var _loginButton:Button;
        private var _loginWithCodeButton:Button;
        private var _environmentImageContainers:Array = [];
        private var _chosenIcon:Bitmap;
        private var _SafeStr_4548:int = 10;
        private var _SafeStr_4557:Array;
        private var _SafeStr_527:Boolean;
        private var _SafeStr_4558:Sprite;

        public function EnvironmentView(_arg_1:LoginFlow)
        {
            _context = _arg_1;
            addEventListener("addedToStage", onAddedToStage);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            var _local_2:Timer = new Timer(20, 1);
            _local_2.addEventListener("timerComplete", onAlignElements);
            _local_2.start();
        }

        private function onAlignElements(_arg_1:TimerEvent=null):void
        {
            LoaderUI.alignAnchors(this, 0, "c", _SafeStr_4555);
            LoaderUI.alignAnchors(_SafeStr_4555, 0, "r", _loginButton);
            LoaderUI.lineUpHorizontallyRevers(_loginButton, 20, _loginWithCodeButton);
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _loginButton.dispose();
            _loginWithCodeButton.dispose();
            for each (var _local_1:Bitmap in _SafeStr_4554)
            {
            };
            _SafeStr_4554 = null;
            _context = null;
        }

        public function get disposed():Boolean
        {
            return (_context == null);
        }

        private function initEnvironmentImages():void
        {
            _SafeStr_4557 = _context.getProperty("live.environment.list").split("/");
            _SafeStr_4554.push(Bitmap(new flag_icon_en_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_pt_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_de_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_es_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_fi_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_fr_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_it_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_nl_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_tr_png()));
            _SafeStr_4554.push(Bitmap(new flag_icon_dev_png()));
        }

        public function init():void
        {
            if (_SafeStr_527)
            {
                return;
            };
            _SafeStr_527 = true;
            _SafeStr_4554 = new Vector.<Bitmap>();
            if (_SafeStr_4557 == null)
            {
                initEnvironmentImages();
            };
            updateEnvironment();
            initView();
        }

        public function updateEnvironment():void
        {
            var _local_1:String = _context.getProperty("environment.id");
            var _local_2:int = _SafeStr_4557.indexOf(_local_1);
            if (_local_2 == -1)
            {
                Logger.log(("Missing environment, require hotel selection! " + _local_1));
                _SafeStr_4556 = 0;
            }
            else
            {
                _SafeStr_4556 = _local_2;
            };
            chooseEnvironment();
        }

        public function initView():void
        {
            var _local_7:int;
            var _local_8:Sprite;
            var _local_10:Bitmap;
            var _local_3:int;
            var _local_2:int;
            var _local_6:int;
            var _local_9:int;
            var _local_4:int;
            var _local_5:int;
            addTitleField();
            _SafeStr_4555 = LoaderUI.createBalloon(640, 100, 0, false, 995918, "none");
            _SafeStr_4555.visible = false;
            addChild(_SafeStr_4555);
            _SafeStr_4558 = new Sprite();
            addChild(_SafeStr_4558);
            _chosenIcon = Bitmap(new flag_icon_selected_png());
            _SafeStr_4558.addChild(_chosenIcon);
            var _local_11:Number = 0.5;
            _SafeStr_4558.scaleY = _local_11;
            _SafeStr_4558.scaleX = _local_11;
            var _local_1:int = 100;
            _local_7 = 0;
            while (_local_7 < _SafeStr_4554.length)
            {
                _local_8 = new Sprite();
                _local_10 = (_SafeStr_4554[_local_7] as Bitmap);
                if (_local_10 != null)
                {
                    _local_8.addChild(_local_10);
                };
                addChild(_local_8);
                _environmentImageContainers.push(_local_8);
                _local_8.name = String(_local_7);
                _local_8.addEventListener("click", onEnvironmentClick);
                _local_11 = 0.5;
                _local_8.scaleY = _local_11;
                _local_8.scaleX = _local_11;
                _local_3 = 80;
                _local_2 = 5;
                _local_6 = (_local_7 % 9);
                _local_9 = int((_local_7 / 9));
                _local_4 = ((_local_6 * _local_3) + (_local_6 * _local_2));
                _local_5 = ((_local_9 * _local_3) + (_local_9 * _local_2));
                _local_8.x = _local_4;
                _local_8.y = (_local_1 + _local_5);
                _local_7++;
            };
            _environmentName = LoaderUI.createTextField("Title", 20, 0xFFFFFF, false, true, false, false);
            _environmentName.width = 260;
            _environmentName.y = 300;
            addChild(_environmentName);
            _loginButton = new ColouredButton("gfreen", "${connection.login.login}", new Rectangle(0, 300, 0, 40), true, onButtonSelect);
            addChild(_loginButton);
            _loginWithCodeButton = new ColouredButton("gfreen", "${connection.login.useTicket}", new Rectangle(0, 300, 0, 40), true, onButtonSelectToken);
            addChild(_loginWithCodeButton);
            chooseEnvironment();
        }

        private function addTitleField():void
        {
            if (!_SafeStr_4547)
            {
                _SafeStr_4547 = LoaderUI.createTextField("${connection.login.environment.choose}", 40, 0xFFFFFF, false, true, false, false, "left");
                _SafeStr_4547.x = 0;
                _SafeStr_4547.y = 0;
                _SafeStr_4547.width = 500;
                _SafeStr_4547.multiline = false;
                _SafeStr_4547.thickness = 50;
                addChild(_SafeStr_4547);
            };
        }

        private function onEnvironmentClick(_arg_1:Event):void
        {
            _SafeStr_4556 = _arg_1.currentTarget.name;
            chooseEnvironment();
            _context.updateEnvironment(_SafeStr_4557[_SafeStr_4556], true);
            onAlignElements();
        }

        private function chooseEnvironment():void
        {
            var _local_1:Sprite = _environmentImageContainers[_SafeStr_4556];
            if (_local_1 == null)
            {
                return;
            };
            _SafeStr_4558.x = ((_local_1.x - ((_SafeStr_4558.width - _local_1.width) / 2)) - 1);
            _SafeStr_4558.y = ((_local_1.y - ((_SafeStr_4558.height - _local_1.height) / 2)) - 1);
            _SafeStr_4558.visible = true;
            _loginButton.active = true;
            updateDescription();
        }

        private function onButtonSelect(_arg_1:DisplayObject):void
        {
            _context.updateEnvironment(_SafeStr_4557[_SafeStr_4556], false);
            _context.showScreen(2);
        }

        private function onButtonSelectToken(_arg_1:DisplayObject):void
        {
            _context.updateEnvironment(_SafeStr_4557[_SafeStr_4556], false);
            _context.showScreen(4);
        }

        private function updateDescription():void
        {
            var _local_1:String = _SafeStr_4557[_SafeStr_4556];
            _environmentName.text = _context.getProperty(("connection.info.name." + _local_1));
        }

        public function get environmentId():String
        {
            return (_SafeStr_4557[_SafeStr_4556]);
        }

        public function get environmentAvailable():Boolean
        {
            var _local_1:String = _context.getProperty("environment.id");
            return (_SafeStr_4557.indexOf(_local_1) > -1);
        }


    }
}