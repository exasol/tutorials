# User-centric Messages

Tell me if this situation sounds familiar. You are working towards a deadline, and the application you are using gets in your way with an error message that leaves you scratching your head.

You started with one problem, the job at hand, and now you have two. The second one is the very piece of software that is supposed to help you solve the first one. Errors make users nervous, and nervous people make more mistakes.

In that situation, a single poorly written message can turn a struggle with the problem into frustration with the application itself.

Now flip that perspective. Do we really want to be the developers putting our users into such a situation?

We can do better than this. All it requires is investing a little learning time and designing messages intentionally.

## Use Messages Sparingly

We live in a world where there is a constant battle for the user's attention. Developers are not marketing people. Our aim is to help and protect our users, so the first question in the design process for every message you plan in your application must be: should it exist?

Intentional software design improves user experience by not interrupting the user's flow unless it is strictly necessary. Every one of us knows applications that pop up "did you know?" style messages that no one asked for. We are not going to make the same mistake.

If you come to the conclusion that you *really* need to communicate something to your user, first opt for non-invasive channels: a note in the status bar, a progress meter instead of a long list of items scrolling over the screen, or just a status indicator icon.

The more intrusive the message is, the more effort you should spend trying to avoid it. Pop-up dialogs in particular are the last option, after you ruled out anything else.

> [!INFO]
> Did you notice that many popular command-line tools print nothing if they succeed? That is not laziness on the part of the developer, but good design. [Success is expected](#the-rule-of-silence).

## Who is the Audience

We should get the most common mistake in message design out of the way right now. No matter how hard you try, your messages will never be useful if you do not know who the audience is.

Make this your first step in the design of any message in your application: Whom is this for?

Developers often have the tendency to write application messages for themselves, not for their users. I know this from first-hand experience, because I made that mistake many times in my career, and it still occasionally happens to me. Identifying the target audience of logs, feedback, and pop-ups is part of intentional software design. You are communicating with people, not machines, and this communication must not be an afterthought.

### Different Channels, Different Readers

When you are identifying your target audience, UI pop-ups or status messages are the easiest. Those are for the person currently using the application. I am not counting situations where that person attaches a screenshot of such a pop-up to a helpdesk ticket, because if that happens regularly, it is usually a sign that the message did not help enough on its own.

Note that an application administrator is still an end user.

The same rules apply to command-line output: even if a console application feels more technical, it is still just another user interface, and its messages are still aimed at the people using it.

Logs are more complicated when it comes to deciding who their target audience is. Under normal circumstances, users do not need to look into logs. If everything goes smoothly, logs are mainly irrelevant to them. Only when things go south do people get really interested in logs. Note that I said *people*. Monitoring tools do not mind reading boring logs. Humans do.

## Think of Everyone, Optimize for One

At this point, you may be thinking: what about support and developers? They need useful messages too. Of course they do. But that does not make them the main audience of every message.

The design rule is straightforward: optimize for the people who are most likely to read the message first. If support and developers can also extract value from it, even better — but not at the cost of clarity for the primary audience.

In practice, that means asking two questions: Who is the *main* audience? Can I also help support and developers *without compromising* the message for that audience?

## What a Good Message Must Do

Once you decided that showing a [message is really necessary](#use-messages-sparingly), and you [identified the target audience](#who-is-the-audience), the next step is designing the content.

A good message does four things:

1. It explains what happened.
2. It explains the consequence.
3. It tells the user what to do next.
4. It does all that without requiring hidden knowledge.

### Information, Warning, or Error

Messages fall roughly into one of three categories.

Information about events or application status is useful when user actions depend on it. For instance, if the application starts a long-running process, a progress indicator helps users decide whether they can continue their work or have to wait for something to finish.

Error messages announce failure conditions that could not automatically be resolved. The first design goal for those is to avoid them, of course. If the application can mitigate an error — for example by retrying an interrupted network API call — we should not bother the user. Still, errors can happen, and when the application cannot fix them autonomously, we need clear user communication.

Warnings are tricky to get right. They are used when the application detects a potential problem that has no consequences for the user yet. Unfortunately, the line between warnings and errors is blurry. Web browsers in the early 2000s displayed a warning if a server's TLS certificate had expired. Users tend to ignore warnings, so today the strategy is to report an expired certificate as a connection error. This protects less tech-savvy users and puts the necessary pressure on the website owner to fix the issue.

### Explain the Problem

When you plan a warning or error message, explain the problem to end users in their lingo. The message must be compact, clear, and aimed at helping the users resolve the underlying issue.

Phrasing the problem so that users understand it takes extra effort. And it is not optional. If the system message is not clear to the end user, intercept it and replace it with one that is.

Bad:

> Connection manager timeout for session 156423780.
> Switching to read-only mode.

Better:

> AcmeInventory lost the connection to `yourcompany.example.com/inventory`. Information displayed in the application is read-only until the connection is up again.

### Give the Next Step

Even more than how it happened, users want to know how to fix the issue.

We can improve the message above by giving them hints on what they can do.

> Please check your network setup. AcmeInventory will automatically try to connect again (next attempt in 5 minutes). For more detailed troubleshooting, please refer to https://example.com/help/troubleshooting

### Avoid Requiring Hidden Knowledge

Cryptic messages irritate users a lot. We will ignore the ones caused by terrible translations, because in the age of LLMs chances are we will see fewer of those.

That leaves us with messages that require hidden knowledge to decipher them. Often they are a sign of laziness on the part of the programmer and very much avoidable.

Let's look at some examples from popular products:

> "Error 0x80004005: Unspecified error." (Microsoft Windows)

How likely is it that the developer who raised the error did not know the error condition? Not very, right? After all, they had to actively add the code in some place. What is missing here is the effort to explain what happened instead of surfacing an internal error code.

> "The Finder can’t complete the operation because some data in ‘…’ can’t be read or written. (Error code -36)" (macOS Finder)

Which operation? What kind of data? What can I do about it? Apple is usually known for taking usability seriously. So the lesson from this example is that message design must be part of mandatory code review. I can hardly imagine that this kind of sloppy phrasing would survive the eyes of an experienced reviewer.

![Something unexpected happened. Reporting this problem will help us understand it better. You can wait a bit and try again or restart your device. That may help. Code: 0xC002001B](error_something_happend.png "Something unexpected happened")

The only weak excuse for this particular error message might be that the problem was security-relevant and the authors were afraid they might disclose information that could be used to attack the system. While over-sharing is a real problem in software design, there must be a better formulation of the problem that is still secure.

## End-User Messages

End-user messages are part of the user interface, and user interfaces exist to help people get work done. That means we should treat every message as a potential interruption of the user's flow.

Interrupting a user is expensive. It breaks concentration, creates uncertainty, and turns attention away from the actual task. So the default position for end-user messages should be restraint. If the user can continue safely without being disturbed, let them continue.

That does not mean staying silent when something important happens. It means we need an excellent reason before we get in the way. A message should earn the attention it demands. The more intrusive it is, the stronger that reason must be.

In practice, this means preferring status indicators, progress bars, or unobtrusive hints over modal dialogs and noisy pop-ups. End-user messages should guide, warn, or protect — not constantly remind the user that the application exists.

If your marketing department asks you to promote something from within the application, remind them that getting in the user's way is a fast route to losing their goodwill.

### UI Messages and Pop-Ups

Few GUI elements interrupt the user flow as aggressively as a pop-up dialog. As software developers, we need to use them responsibly.

More than with any other message channel, your first question must be: can I achieve the same communication with a more user-friendly alternative?

To set the mood for this section, let's look at a particularly problematic example of a pop-up from an admittedly older version of Microsoft Excel.[^9]

![Dialog "Do you want to save the changes you made to 'Book1'?" with confusing buttons (from Microsoft Excel)](pop-up_save_book1_excel.png "Do you want to save the changes you made to 'Book1'?")

It already starts with the wrong signal. The information icon suggests a harmless notice, but we are looking at a confirmation dialog. The application is asking the user to make a decision that affects their work. If unsaved changes are at stake, this is no place for a cheerful little info symbol.

The buttons are even worse. `Yes` and `OK` are vague, and `Cancel` is only useful if the user already understands what is going on. Modern interfaces use imperative labels to avoid ambiguity.

The buttons in the dialog above force the user to interpret the dialog first and act second. This is a recipe for human error.

The message also withholds context that the user absolutely needs. Why did this pop-up appear? Is the user closing the file, exiting the application, or triggering something else? And where exactly will `Book1` be saved? If it was never saved before, that is not a minor detail. It is the whole point.

Even the window close button is a trap. Does clicking `X` mean `Cancel`? Does it dismiss the dialog? Does it continue the close operation? The user should not have to run a small experiment to find out.

So this pop-up manages to do almost everything wrong at once: wrong visual category, vague buttons, missing context, and unclear consequences. It interrupts the user at a sensitive moment and then turns a simple decision into guesswork.

With modern auto-save implemented properly, the user should never have to see this dialog in the first place.

### Buttons are Part of the Message

Let's fix the mess we saw in the last dialog and focus on what users read first: the buttons.

`Save and Exit`, `Exit Without Saving`, and `Stay in Excel` tell the user what will happen if they choose a button. We are very clear here, so we account for the very real user impulse to click too fast just to make the dialog go away.

![Improved Excel exit dialog with unsaved changes, save location details and clear action buttons](pop-up_save_fixed.png "Improved exit confirmation dialog for Excel")

I did not mention it in the last section because it was not important there, but proper dialog design must also ensure that all buttons are keyboard-navigable. Only `Yes` had a keyboard shortcut in the original example.

### Console Output Is Still User Communication

Console applications have a bad habit of making developers forget that they still have a user interface. The absence of windows and buttons does not change that. The command line is still a UI, and whatever an application prints to it is still user communication.

This is where developer psychology often blurs the line between application output and logs. After all, the console feels technical. We run commands there, we inspect stack traces there, and many of us are used to dumping internal details onto a terminal during development. But the fact that developers are trained at reading noisy output does not make it good design.

Users of command-line tools still need the same things as users of graphical applications: clear feedback, predictable behavior, and messages that help them reach their goal. The medium is more spartan, but the rules of proper UX design still apply.

Command-line tools also come with established conventions, and they exist for good reasons. Good CLI output is compact, readable, and intentional. A successful command should usually be quiet.

Regular output belongs on standard output, diagnostics on standard error. Messages should explain what happened in plain language, avoid implementation trivia, and help users recover when something goes wrong. If you dump internal noise onto the terminal just because it feels technical, you disrupt chained processing and make your users' lives harder.

The excellent "Command Line Interface Guidelines"[^10] summarize the mindset nicely:

> "Today, even though many CLI programs are used primarily (or even exclusively) by humans, a lot of their interaction design still carries the baggage of the past. It’s time to shed some of this baggage: if a command is going to be used primarily by humans, it should be designed for humans first."

### What End-User Messages Should Never Contain

There are also clear red lines in message design. Some information simply has no business showing up in end-user messages, no matter how convenient it may feel during development.

#### Mind the OpSec

The first category is anything that weakens operational security. Passwords, access tokens, session secrets, private keys, and similar data must never appear in a message. Not even partially if that partial value helps an attacker. If such information reaches the screen, we have turned a usability problem into a security incident.

#### Respect Privacy

The second category is private data never intended for that user. That includes personal information about other users, internal identifiers with business relevance, confidential document names, email addresses, customer data, and anything else the current recipient has no need and no right to see. A message should help users do their work, not accidentally leak somebody else's.

#### Don't be Cute

The third category is humor that can age badly, miss the mood, or simply make the situation worse. When users see a warning or error, they are usually trying to get unstuck. This is not the best moment for a developer to test a comedy career. A joke that lands poorly makes the application feel careless. If you are in doubt, leave it out. Some people argue that end-user error messages should never contain humor at all, and they have a point.

Here is an example of an attempt at humor that does not land even if you allow it. I have seen the GitHub unicorn many times. And so has everyone else who frequents GitHub.

![The Unicorn everyone gets to see: GitHub timeout messages](the_unicorn_everyone_meets.png)

But of course, there is always a worse example. This one is from HiBob and straight up mocks the user.

![img.png](img.png)

This is a dead end with a wink.

The message tells the user what the system cannot do, but not what they should do instead. And the joke at the end only makes that worse. If a user asks about approval workflows, they need guidance, not a little comedy routine about AI magic.

A better phrasing would be:

> I can help with attendance and timesheet records. Unfortunately, I cannot help with approval workflows. Please check the user guide on how to approve timesheets or contact our support team.

That being said, if you build a chatbot into your application, back it with the user guide. Even when it cannot solve the problem directly, it can at least point the user to the right section instead of leaving them at a dead end.

## Logs

The main difference between console output or a UI message on the one hand and logs on the other is that logs are an asynchronous communication channel. Sure, you can look at a log in realtime, but that is not its main purpose.

A well-designed log allows you to find out what happened after it did.

### Humans Still Read Logs

Logs are still the main means to investigate problems with software that runs non-interactively, multi-user software, and anything with a distributed architecture. We already discussed that error messages put users under stress. Multiply that by the number of lines in a log when you are forced to debug a problem under time pressure.

Depending on how much thought went into the log design, the debugging session will either end with a reader happy that they found the root cause of an issue quickly or angry about the time wasted deciphering gibberish. Even in the age of LLMs, your first design goal must be to serve the person reading the log.

### Target Audiences by Log Level

Logs have multiple audiences, ranging from end users, application administrators, and system admins to support staff and finally the developer who wrote the software. As a result, log designers need to deal with the unavoidable conflict of interest between those groups. Or, if you prefer a more positive perspective, we need to solve an optimization problem.

Luckily, our predecessors came up with the concept of log levels to help the rest of us target our log messages correctly. A typical log level hierarchy has `FATAL`, `ERROR`, `WARNING`, `INFO`, `DEBUG`, and `TRACE`. There are, of course, many variants out there, but the general idea is the same.

Not only do these levels express criticality, they are also a valuable tool in our toolbox for deciding what goes into the log message.

In most applications the default log level is `INFO` or sometimes `WARNING`. This means that if the log is printed on the console, end users get to see all messages with that level or higher. Consequently, end users are the target audience of these messages.

`DEBUG` is a hybrid, because there are two potential groups debugging an application: IT support and developers. You read that correctly: especially in enterprise environments, IT people are often the first to look into debug logs. Their job is to unblock application users if they can. When issues reach developers too early, that is usually a sign that our messages and diagnostics are not serving support well enough.

As developers, our first instinct is often to treat anything labeled `DEBUG` as developer-only. In practice, that is frequently not the case.

At `TRACE` level, implementation-level detail is often appropriate.

### The Rule of Silence

A good log does not narrate everything the application does. It records what matters. The rule of silence[^8] means that expected success usually does not need a log entry. Silence is not neglect. It is restraint in service of relevance.

Every extra line competes with the important ones. If we log too much, failures, unusual conditions, and meaningful decisions get buried in routine chatter. A log then stops helping and starts slowing people down. That is why compactness is a design goal. Smaller logs are easier to scan, store, and transfer, but more importantly, they leave room for the interesting parts to stand out.

A useful rule of thumb is this: every log entry should justify its existence. If removing it makes it harder to understand a problem later, keep it. If removing it only makes the log more compact, remove it.

The more disciplined we are about silence, the more informative the remaining log becomes. A log must not drown the interesting parts in irrelevance.

#### Level INFO Needs Special Care

Messages on log level `INFO` must be crafted especially carefully. This is usually the lowest log level enabled on production systems. Unlike `WARNING`, `ERROR`, or `FATAL`, it exists to allow logging information under normal operating conditions. And that is why it is easy to overdo it. As a rule of thumb, never log repetitive information on level `INFO`. If you feel that something should be logged, keep it compact and relevant.

Here is an example of the connection message that `remotelog-lua` adds at the first log line. Since that will be in all logs, it must be important information.
