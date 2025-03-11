import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini_chat/message.dart';
import 'package:flutter_gemini_chat/themeNotifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
class MyHomePage extends ConsumerStatefulWidget{

  const MyHomePage({super.key});
  
  @override
  ConsumerState<MyHomePage> createState() => _MyhomepageState();
}




class _MyhomepageState extends ConsumerState<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = <Message>[];

  bool _isLoading = false;

  callGeminiModel() async {
    // call the model
    try{

      if (_controller.text.isNotEmpty){
        _messages.add(Message(text: _controller.text, isUser: true));
        _isLoading = true;
      }
      final model = GenerativeModel(model: 'gemini-1.5-pro-002', apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final promt = _controller.text.trim();
      final content = [Content.text(promt)];
      final response = await model.generateContent(content);

      setState(() {
       
        _messages.add(Message(text: response.text!, isUser: false));
         _isLoading = false;
      });

      _controller.clear();
    }catch(e){
      print("error: $e");
    }
    
    
    

  }
  
  
  @override
  Widget build(BuildContext context){
    final currentTheme = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/gpt-robot.png'),
                SizedBox(width: 10),
                Text('Gemini Chat', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            GestureDetector(
              onTap: (){
                ref.read(themeProvider.notifier).toggleTheme();
              },
              child: (currentTheme == ThemeMode.light) ? Icon(Icons.light_mode, color: Theme.of(context).colorScheme.primary,) : Icon(Icons.dark_mode, color: Theme.of(context).colorScheme.secondary)
              )
              ,
          ], 
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index){
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message.isUser ?
                        Theme.of(context).colorScheme.primary :
                        Theme.of(context).colorScheme.secondary,
                        borderRadius: message.isUser ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                      ) : BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      ),
                      child: Text(
                        message.text,
                        style: message.isUser ? 
                        Theme.of(context).textTheme.bodyMedium :
                        Theme.of(context).textTheme.bodySmall,
                        ),
                    ),
                  ),
                );
              },
            ),
          ),

          // user input
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0, top: 16.0, left: 16.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        hintText: "Input a message",
                        hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.grey
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  _isLoading ? 
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ):
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: callGeminiModel,
                      child: Image.asset('assets/send.png'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  } 
}