import UIKit
import AVFoundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let string = "あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら、うつくしい森で飾られたモーリオ市、郊外のぎらぎらひかる草の波。またそのなかでいっしょになったたくさんのひとたち、ファゼーロとロザーロ、羊飼のミーロや、顔の赤いこどもたち、地主のテーモ、山猫博士のボーガント・テストゥパーゴなど、いまこの暗い巨きな石の建物のなかで考えていると、みんなむかし風のなつかしい青い幻燈のように思われます。"

let synthesizer = AVSpeechSynthesizer()
let voice = AVSpeechSynthesisVoice(language: "ja_JP")
let utterance = AVSpeechUtterance(string: string)
utterance.voice = voice
synthesizer.speak(utterance)
