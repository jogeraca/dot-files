//hvp
//kidbrazil
//mcrow
//ninjonas
//tominabx

#include QMK_KEYBOARD_H
#include "bootloader.h"
#ifdef PROTOCOL_LUFA
  #include "lufa.h"
  #include "split_util.h"
#endif
#ifdef SSD1306OLED
  #include "ssd1306.h"
  #include <string.h>
#endif

extern keymap_config_t keymap_config;

#ifdef RGBLIGHT_ENABLE
//Following line allows macro to read current RGB settings
extern rgblight_config_t rgblight_config;
#endif

uint8_t is_master;


// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.

enum layers {
  _DEFAULTS = 0,
  _DVORAK = 0,
  _QWERTY,
  _LOWER,
  _RAISE,
  _ADJUST,
  _LAUNCH
};

enum custom_keycodes {
  DVORAK= SAFE_RANGE,
  QWERTY, 
  LOWER,
  RAISE,
  ADJUST,
  LAUNCH,
  BACKLIT,
  RGBRST
};

enum {
  TD_CAPLOCK,
  TD_ALT,
  TD_SUPER,
  TD_DOLLAR,
  TD_BCK
};

enum macro_keycodes {
  KC_SAMPLEMACRO,
};

#define XXXXXX   KC_NO 
#define CTLTB CTL_T(KC_TAB)
#define RSHIFT TD(TD_CAPLOCK)
#define KC_LCH LT(LAUNCH, KC_SPC) 
#define SUPER TD(TD_SUPER)
#define TD_DLR TD(TD_DOLLAR)

#define KC______ KC_TRNS

#define KC_ALT TD(TD_ALT)
#define KC_BCK TD(TD_BCK)


#define FIREFOX LGUI(KC_F1)
#define TELEGRM LGUI(KC_F3)
#define DBEAVER SGUI(KC_B)
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_DVORAK] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       KC_ESC, KC_SCLN, KC_COMM,  KC_DOT,    KC_P,    KC_Y,                     KC_F,    KC_G,    KC_C,    KC_R,    KC_L,  KC_BCK,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
        CTLTB,    KC_A,    KC_O,    KC_E,    KC_U,    KC_I,                     KC_D,    KC_H,    KC_T,    KC_N,    KC_S, KC_MINS,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      KC_LSFT, KC_QUOT,    KC_Q,    KC_J,    KC_K,    KC_X,                     KC_B,    KC_M,    KC_W,    KC_V,    KC_Z, KC_RSFT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_LCH,                   KC_ENT,   RAISE,  KC_ALT
  //                           '--------------------------'                '--------------------------'
  ),

  [_QWERTY] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       KC_ESC,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                     KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,  KC_BCK,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
        CTLTB,    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                     KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_QUOT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      KC_LSFT,    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                     KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH, KC_RSFT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
  //                           '--------------------------'                '--------------------------'
  ),

  [_LOWER] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       KC_ESC, KC_LBRC, KC_LCBR, KC_RCBR, KC_LPRN,  KC_EQL,                  KC_PAST, KC_RPRN, KC_PLUS, KC_RBRC, KC_EXLM, KC_BSPC,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       TD_DLR, KC_PGUP, KC_PGDN, KC_HOME,  KC_END, KC_PSCR,                   KC_DEL, KC_LEFT, KC_DOWN,   KC_UP, KC_RGHT, KC_HASH,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
        CTLTB, XXXXXXX,  XXXXXX,  XXXXXX, KC_AMPR, KC_CIRC,                  KC_PERC,  KC_GRV, KC_BSLS,   KC_AT, KC_SLSH,  RSHIFT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
//                             '--------------------------'                '--------------------------'
  ),

  [_RAISE] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      KC_SCLN,    KC_7,    KC_5,    KC_3,    KC_1,    KC_9,                     KC_0,     KC_2,   KC_4,    KC_6,    KC_8, KC_BSPC,  
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,                    KC_F7,   KC_F8,   KC_F9,  KC_F10,  KC_F11,  KC_F12,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      KC_RSFT, KC_MUTE, KC_VOLD, KC_VOLU, KC_MPLY,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX, KC_RSFT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
  //                           '--------------------------'                '--------------------------'
  ),

  [_ADJUST] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       RGBRST,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,                   DVORAK,  QWERTY,  XXXXXX,  XXXXXX,  XXXXXX,  KC_PWR,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      RGB_TOG, RGB_HUI, RGB_SAI, RGB_VAI,  XXXXXX,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,   RESET,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      RGB_MOD, RGB_HUD, RGB_SAD, RGB_VAD, XXXXXX, XXXXXX,                     XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX , XXXXXX, KC_SLEP,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
  //                           '--------------------------'                '--------------------------'
  ),

  [_LAUNCH] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      FIREFOX,  XXXXXX, TELEGRM,  XXXXXX,  XXXXXX,  XXXXXX,                  DBEAVER,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_LCH,                   KC_ENT,   RAISE,  KC_ALT  
  //                           '--------------------------'                '--------------------------'
  )
};



void back_tap(qk_tap_dance_state_t *state, void *user_data) { tap_code(KC_BSPACE); }

void back_finished(qk_tap_dance_state_t *state, void *user_data) { if(!(state->interrupted || !state->pressed)) tap_code16(LCTL(KC_BSPACE)); }

// Tap Dance definitions
qk_tap_dance_action_t tap_dance_actions[] = {
  [TD_ALT] = ACTION_TAP_DANCE_DOUBLE(KC_RALT, KC_LALT),
  [TD_CAPLOCK] = ACTION_TAP_DANCE_DOUBLE(KC_LSFT, KC_CAPS),
  //each tap, on finished, and reset. Normally register_code on press unregister on reset so keys can be held down:
  [TD_BCK] = ACTION_TAP_DANCE_FN_ADVANCED(back_tap, back_finished, NULL), 
  [TD_SUPER] = ACTION_TAP_DANCE_DOUBLE(KC_LGUI, KC_MEH),
  [TD_DOLLAR]= ACTION_TAP_DANCE_DOUBLE(KC_DLR, KC_TILD)
};

int RGB_current_mode;



const rgblight_segment_t PROGMEM layer_dvorak_lights[] = RGBLIGHT_LAYER_SEGMENTS( 
 {0, 2, HSV_YELLOW},
 {10, 5, HSV_BLUE},
 {15, 3, HSV_BLUE},
 {18, 3, HSV_BLUE}

);
const rgblight_segment_t PROGMEM layer_qwerty_lights[] = RGBLIGHT_LAYER_SEGMENTS(
  {0, 10, HSV_TEAL}
);
const rgblight_segment_t PROGMEM layer_lower_lights[] = RGBLIGHT_LAYER_SEGMENTS(
 {0, 10, HSV_ORANGE},
 {10, 5, HSV_BLUE},
 {15, 3, HSV_BLUE},
 {18, 3, HSV_BLUE}
);
const rgblight_segment_t PROGMEM layer_raise_lights[] = RGBLIGHT_LAYER_SEGMENTS(
  {0, 10, HSV_PURPLE}
);
const rgblight_segment_t PROGMEM layer_adjust_lights[] = RGBLIGHT_LAYER_SEGMENTS( 
    {0, 6, HSV_GREEN},
 	{9, 2, HSV_GREEN},
 	{17, 2, HSV_GREEN},
 	{23, 2, HSV_GREEN}
 );
const rgblight_segment_t PROGMEM layer_launch_lights[] = RGBLIGHT_LAYER_SEGMENTS(
    {0, 10, HSV_RED}
);
const rgblight_segment_t PROGMEM layer_capslock_lights[] = RGBLIGHT_LAYER_SEGMENTS(
    {0, 5, HSV_CYAN}
);

 // Now define the array of layers. Later layers take precedence
const rgblight_segment_t* const PROGMEM my_rgb_layers[] = RGBLIGHT_LAYERS_LIST(
  layer_dvorak_lights, 
  layer_qwerty_lights, 
  layer_lower_lights,
  layer_raise_lights,
  layer_adjust_lights,
  layer_launch_lights,
  layer_capslock_lights
);

void keyboard_post_init_user(void) {
// Enable the LED layers
//rgblight_layers = my_rgb_layers;
  rgblight_mode(10);// haven't found a way to set this in a more useful way 

    uint16_t default_hue = rgblight_config.hue;
     rgblight_enable_noeeprom(); 
     layer_state_set_user(layer_state);
     rgblight_mode_noeeprom(RGBLIGHT_MODE_STATIC_LIGHT);
     for (uint16_t i = 255; i > 0; i--) {
          rgblight_sethsv_noeeprom((i + default_hue) % 255, rgblight_config.sat, rgblight_config.val);
          matrix_scan();
          wait_ms(10);
     }
  layer_state_set_user(layer_state);
}


layer_state_t layer_state_set_user(layer_state_t state) {
    rgblight_set_layer_state(0, layer_state_cmp(state, _DEFAULTS) && layer_state_cmp(default_layer_state,_DVORAK));
    rgblight_set_layer_state(1, layer_state_cmp(state, _DEFAULTS) && layer_state_cmp(default_layer_state,_QWERTY));
    rgblight_set_layer_state(2, layer_state_cmp(state, _LOWER));
    rgblight_set_layer_state(3, layer_state_cmp(state, _RAISE));
    rgblight_set_layer_state(4, layer_state_cmp(state, _ADJUST));
    rgblight_set_layer_state(5, layer_state_cmp(state, _LAUNCH));
    return state;
}
bool led_update_user(led_t led_state) {
    rgblight_set_layer_state(6, led_state.caps_lock);
    return true;
}








// Setting ADJUST layer RGB back to default
void update_tri_layer_RGB(uint8_t layer1, uint8_t layer2, uint8_t layer3) {
  if (IS_LAYER_ON(layer1) && IS_LAYER_ON(layer2)) {
    layer_on(layer3);
  } else {
    layer_off(layer3);
  }
}

void matrix_init_user(void) {
    #ifdef RGBLIGHT_ENABLE
      RGB_current_mode = rgblight_config.mode;
    #endif
//#ifdef SSD1306OLED
//iota_gfx_init();   // turns on the display
//#endif
}

//SSD1306 OLED update loop, make sure to add #define SSD1306OLED in config.h
#ifdef SSD1306OLED

// When add source files to SRC in rules.mk, you can use functions.
const char *read_layer_state(void);
const char *read_logo(void);
void set_keylog(uint16_t keycode, keyrecord_t *record);
const char *read_keylog(void);
const char *read_keylogs(void);

// const char *read_mode_icon(bool swap);
// const char *read_host_led_state(void);
// void set_timelog(void);
// const char *read_timelog(void);

void matrix_render_user(struct CharacterMatrix *matrix) {
  if (is_keyboard_master()) {
    matrix_write(matrix, read_layer_state());
    matrix_write(matrix, read_keylog());
  } else {
    matrix_write(matrix, read_logo());
  }
}

void matrix_update(struct CharacterMatrix *dest, const struct CharacterMatrix *source) {
  if (memcmp(dest->display, source->display, sizeof(dest->display))) {
    memcpy(dest->display, source->display, sizeof(dest->display));
    dest->dirty = true;
  }
}

void iota_gfx_task_user(void) {
  struct CharacterMatrix matrix;
  matrix_clear(&matrix);
  matrix_render_user(&matrix);
  matrix_update(&display, &matrix);
}
#endif  //SSD1306OLED





void persistent_default_layer_set(uint16_t default_layer) {
  eeconfig_update_default_layer(default_layer);
  default_layer_set(default_layer);
}
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
    #ifdef SSD1306OLED
      set_keylog(keycode, record);
    #endif
  }

  switch (keycode) {
    case DVORAK:
      if (record->event.pressed) {
        persistent_default_layer_set(1UL<<_DVORAK);
      }
      return false;
      break;
    case QWERTY:
      if (record->event.pressed) {
        persistent_default_layer_set(1UL<<_QWERTY);
      }
      return false;
      break;
    case LOWER:
      if (record->event.pressed) {
        layer_on(_LOWER);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_LOWER);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      }
      return false;
      break;
    case RAISE:
      if (record->event.pressed) {
        layer_on(_RAISE);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_RAISE);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      }
      return false;
      break;
    case ADJUST:
        if (record->event.pressed) {
          layer_on(_ADJUST);
        } else {
          layer_off(_ADJUST);
        }
        return false;
        break;
    case LAUNCH:
        if (record->event.pressed) {
          layer_on(_LAUNCH);
        } else {
          layer_off(_LAUNCH);
        }
        return false;
        break;
    case RGB_MOD:
      #ifdef RGBLIGHT_ENABLE
        if (record->event.pressed) {

          rgblight_mode(RGB_current_mode);
          rgblight_step();
          RGB_current_mode = rgblight_config.mode;
        }
      #endif
      return false;
      break;
    case RGBRST:
      #ifdef RGBLIGHT_ENABLE
        if (record->event.pressed) {
          eeconfig_update_rgblight_default();
          rgblight_enable();
          RGB_current_mode = rgblight_config.mode;
        }
      #endif
      break;
  }
  return true;
}



//SSD1306 OLED update loop, make sure to add #define SSD1306OLED in config.h
#ifdef OLED_DRIVER_ENABLE
oled_rotation_t oled_init_user(oled_rotation_t rotation) {
  if (!is_keyboard_master()) {
    return OLED_ROTATION_180;  // flips the display 180 degrees if offhand
  }
  return rotation;
}
// When add source files to SRC in rules.mk, you can use functions.
const char *read_layer_state(void);
const char *read_logo(void);
void set_keylog(uint16_t keycode, keyrecord_t *record);
const char *read_keylog(void);
const char *read_keylogs(void);


const char *read_mode_icon(bool swap);
// const char *read_host_led_state(void);
// void set_timelog(void);
// const char *read_timelog(void);


void oled_render_layer_state(void) {
  char string [24]; 
  switch (get_highest_layer(default_layer_state|layer_state))
  {
      case _QWERTY:
        oled_write_ln_P(PSTR("Layer: QWERTY"),false);
        break;
      case _DVORAK:
        oled_write_ln_P(PSTR("Layer: COLEMAK"),false);
        break;    
      case _LOWER:
        oled_write_ln_P(PSTR("Layer: Numbers"),false);
        break;
      case _RAISE:
        oled_write_ln_P(PSTR("Layer: Symbols"),false);
        break;
      case _ADJUST:
        oled_write_ln_P(PSTR("Layer: Command"),false);
        break;
      case _LAUNCH:
        oled_write_ln_P(PSTR("Layer: Numpad"),false);
        break;	
      default:
        snprintf(string, sizeof(string), "%ld",layer_state);
        oled_write_P(PSTR("Layer: Undef-"),false);
        oled_write_ln(string, false);
    }
 }

/*
void matrix_render_user(struct CharacterMatrix *matrix) {
  if (has_usb()) {
    // If you want to change the display of OLED, you need to change here
    matrix_write_ln(matrix, read_layer_state());
    matrix_write_ln(matrix, read_keylog());
    //matrix_write_ln(matrix, read_keylogs());
    //matrix_write_ln(matrix, read_mode_icon(keymap_config.swap_lalt_lgui));
    //matrix_write_ln(matrix, read_host_led_state());
    //matrix_write_ln(matrix, read_timelog());
  } else {
    matrix_write(matrix, read_logo());
  }
}
*/

char keylog_str[24] = {};
const char code_to_name[60] = {
    ' ', ' ', ' ', ' ', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
    'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    'R', 'E', 'B', 'T', '_', '-', '=', '[', ']', '\\',
    '#', ';', '\'', '`', ',', '.', '/', ' ', ' ', ' '};

void set_keylog(uint16_t keycode, keyrecord_t *record) {
  char name = ' ';
    if ((keycode >= QK_MOD_TAP && keycode <= QK_MOD_TAP_MAX) ||
        (keycode >= QK_LAYER_TAP && keycode <= QK_LAYER_TAP_MAX)) { keycode = keycode & 0xFF; }
  if (keycode < 60) {
    name = code_to_name[keycode];
  }

  // update keylog
  snprintf(keylog_str, sizeof(keylog_str), "%dx%d, k%2d : %c",
           record->event.key.row, record->event.key.col,
           keycode, name);
}

void oled_render_keylog(void) {
    oled_write(keylog_str, false);
}

void render_bootmagic_status(bool status) {
    /* Show Ctrl-Gui Swap options */
    static const char PROGMEM logo[][2][3] = {
        {{0x97, 0x98, 0}, {0xb7, 0xb8, 0}},
        {{0x95, 0x96, 0}, {0xb5, 0xb6, 0}},
    };
    if (status) {
        oled_write_ln_P(logo[0][0], false);
        oled_write_ln_P(logo[0][1], false);
    } else {
        oled_write_ln_P(logo[1][0], false);
        oled_write_ln_P(logo[1][1], false);
    }
}

void oled_render_logo(void) {
    static const char PROGMEM crkbd_logo[] = {
        0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, 0x92, 0x93, 0x94,
        0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0, 0xb1, 0xb2, 0xb3, 0xb4,
        0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, 0xd0, 0xd1, 0xd2, 0xd3, 0xd4,
        0};
    oled_write_P(crkbd_logo, false);
}

void oled_task_user(void) {
    if (is_master) {
        oled_render_layer_state();
        oled_render_keylog();
    } else {
        oled_render_logo();
    }
}

#endif // OLED_DRIVER_ENABLE
