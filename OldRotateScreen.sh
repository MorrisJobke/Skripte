################## Compiz Prevention
function compiz_on {
   USER=`ps -ef |grep metacity |grep -v grep|awk -F" " '{print $1}'`
   #if [ "$(pidof metacity)" ]
   if [ "$USER" ]
   then
      echo 'Activating Compiz...'
      #DISPLAY=":0.0" sudo -H -u $USER /usr/bin/compiz --replace &
      #DISPLAY=":0.0" sudo -H -u $USER /usr/bin/emerald --replace &
   fi
}
	
function compiz_off {
   USER=`ps -ef | grep compiz.real | grep -v grep | awk -F" " '{print $1}'`
   #if [ "$(pidof compiz.real)" ]
   if [ "$USER" ]
   then
      echo 'Compiz Active. Deactivating...'
      DISPLAY=":0.0" sudo -H -u $USER /usr/bin/metacity --replace &
   fi
}
##################################################
	
######################## Keycodes PgUp/PgDown
function keymap() {
   USER=`who |grep tty7 |awk -F" " '{print $1}'`
   if [ "$USER" ]
   then
      case "$1" in
      1)
         echo 'Modifying xmodmap ...'
         DISPLAY=":0.0" sudo -H -u $USER xmodmap -e 'keycode 105 = Prior'
         DISPLAY=":0.0" sudo -H -u $USER xmodmap -e 'keycode 99 = Next'
         ;;
      *)
         echo 'xmodmap normal ...'
         DISPLAY=":0.0" sudo -H -u $USER xmodmap -e 'keycode 105 = Next'
         DISPLAY=":0.0" sudo -H -u $USER xmodmap -e 'keycode 99 = Prior'
         ;;
      esac
   fi
}
###############################
function rotate() {
	
    case "$1" in
        3|right) N=3; T=cw ; compiz_off ; keymap 0 ;;
        1|left) N=1; T=ccw ; compiz_off ; keymap 1 ;;
        2|inverted) N=2; T=half ; compiz_off; keymap 0 ;;
        0|normal) N=0; T=none ; compiz_on ; keymap 0 ;;
        *)
           echo -e "Usage:\n  $(basename $0) [left|right|inverted|normal]";
 echo -e "if no option is given, rotates the screen 90 degrees to the right.\n";
	
           exit 1
           ;;
    esac
	
    #xrandr -o $N & \
	
    #More secure
    if [ "`/usr/bin/xrandr -o $N -v | grep -i 'randr' | wc -l`" -ne "1" ]
    then
        echo '!! Something went wrong...'
        export DISPLAY=":0.0"
        export XAUTHORITY=/var/lib/gdm/\:0.Xauth
        #/usr/bin/xset -display $DISPLAY dpms
        echo 'Trying to unrotate again...'
        /usr/bin/xrandr -o $N &
    fi
	
    xsetwacom set 'Serial Wacom Tablet' Rotate $T & \
    echo $N > $STATUS_FILE
}
	
if [ "$#" == "0" ]; then
    rotate $(((3+0$(cat $STATUS_FILE 2>/dev/null))%4))
else
    rotate $1
fi

