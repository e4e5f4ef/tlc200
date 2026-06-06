#!/bin/bash
# Двічі клікни цей файл, щоб закомітити й запушити бриф на GitHub.
# Перед першим використанням зроби разове налаштування (див. інструкцію).

cd "$(dirname "$0")" || exit 1

# 1) Ініціалізувати репозиторій, якщо ще немає
if [ ! -d .git ]; then
  git init
  git branch -M main
  echo "✓ Створено локальний git-репозиторій у цій теці."
fi

# 2) Повідомлення коміту (Enter = поточна дата/час)
echo ""
read -p "Повідомлення коміту (Enter = дата): " MSG
if [ -z "$MSG" ]; then
  MSG="Оновлення брифа $(date '+%Y-%m-%d %H:%M')"
fi

# 3) Додати файли брифа й закомітити
git add index.html
# Якщо хочеш коммітити всю теку — заміни рядок вище на:  git add -A
git commit -m "$MSG" || { echo "Немає змін для коміту."; }

# 4) Запушити, якщо налаштований remote 'origin'
if git remote | grep -q origin; then
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  git push -u origin "$BRANCH" && echo "✓ Запушено в origin/$BRANCH"
else
  echo ""
  echo "⚠ Немає віддаленого репозиторію (origin)."
  echo "  Додай його один раз командою:"
  echo "    git remote add origin https://github.com/ЛОГІН/НАЗВА.git"
  echo "  і запусти цей файл ще раз."
fi

echo ""
read -p "Готово. Натисни Enter, щоб закрити."
